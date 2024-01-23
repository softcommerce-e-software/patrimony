import 'dart:convert';
import 'dart:io';

import "package:crypto/crypto.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:patrimony/data/user/user_datasource.dart';
import 'package:patrimony/domain/utils/errors.dart';
import 'package:patrimony/entity/user_entity.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const String APPLE = 'apple';
const String GOOGLE = 'google';
const String _USERS = 'users';

class UserDataSourceImpl implements UserDataSource {
  final GoTrueClient _auth;
  final SupabaseClient _db;

  UserDataSourceImpl(this._auth, this._db);

  @override
  Future<bool> login(String provider) async {
    try {
      if (provider == APPLE) {
        await _signInWithApple();
      } else {
        await _signInWithGoogle();
      }
      return true;
    } catch (e) {
      throw LoginError();
    }
  }

  Future<AuthResponse> _signInWithApple() async {
    final rawNonce = _auth.generateRawNonce();
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );
    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const AuthException(
          'Could not find ID Token from generated credential.');
    }

    return _auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );
  }

  Future<AuthResponse> _signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }
      var a = await _auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return a;
    } catch (e){
      print(e);
      throw e;
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
      var id = _auth.currentUser?.id;
      if (id != null) {
        var response = await _db
            .from(_USERS)
            .select()
            .eq('id', id);
        return response.map((e) => UserEntity.fromJson(e)).firstOrNull?.isAdmin == true;
      } else {
        throw RemoteFailure();
      }
    } catch (_) {
      throw RemoteFailure();
    }
  }
}