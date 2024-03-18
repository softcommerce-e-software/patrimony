import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patrimony/data/user/user_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';

const String APPLE = 'apple';
const String GOOGLE = 'google';

class UserDataSourceImpl implements UserDataSource {
  final FirebaseAuth _auth;
  UserDataSourceImpl(this._auth);

  @override
  Future<bool> login(String provider) async {
    try {
      if (provider == APPLE) {
        return await _signInWithApple();
      } else {
        return await _signInWithGoogle();
      }
    } catch (e) {
      throw LoginError();
    }
  }

  Future<bool> _signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    var response = await _auth.signInWithProvider(appleProvider);
    return response.user != null;
  }

  Future<bool> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    var response = await _auth.signInWithCredential(credential);
    return response.user != null;
  }

  @override
  Future<bool> logout() async {
    await _auth.signOut();
    return true;
  }

  @override
  Future<bool> isLoggedUser() async {
    return _auth.currentUser != null;
  }
}