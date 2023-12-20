import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patrimony/data/user/user_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';

const String APPLE = 'apple';
const String GOOGLE = 'google';
const String _USERS = 'users';

class UserDataSourceImpl implements UserDataSource {
  final _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db;

  UserDataSourceImpl(this._db);

  @override
  Future<bool> login(String provider) async {
    try {
      if (provider == APPLE) {
        var appleProvider = AppleAuthProvider();
        if (kIsWeb) {
          await _auth.signInWithPopup(appleProvider);
        } else {
          await _auth.signInWithProvider(appleProvider);
        }
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
      return true;
    } catch (_) {
      throw LoginError();
    }
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

  @override
  Future<bool> isAdmin() async {
    try {
      var response = await _db
        .collection(_USERS).doc(_auth.currentUser?.uid ?? '')
        .get();
      return response.data()?['isAdmin'] == true;
    } catch (_) {
      throw RemoteFailure();
    }
  }
}