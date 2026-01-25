import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_wise/firebase_options.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<bool> logOrRegister();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  @override
  Future<bool> logOrRegister() async {
    _initializeGoogleSignIn();
    return _isGoogleSignInInitialized;
  }

  Future<void> _initializeGoogleSignIn() async {
    try{
      await _googleSignIn.initialize();
      _isGoogleSignInInitialized = true;
    }
    catch(e){
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  Future<void> _ensureGoogleSignInInitialized() async {
    if(!_isGoogleSignInInitialized){
      await _initializeGoogleSignIn();
    }
  }

  Future<GoogleSignInAccount> signInWithGoogle() async {
    await _ensureGoogleSignInInitialized(); 

    try{
      final GoogleSignInAccount  account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      return account;
    }
    catch(e){
      print('Unexpected Google Sign In Error: $e ');
      rethrow;
    }

  }


  //Handle Silent Authentication
  Future<GoogleSignInAccount?> attemptSilentSignIn() async {
    await _ensureGoogleSignInInitialized();

    try{
      final result = _googleSignIn.attemptLightweightAuthentication();

      if(result is Future<GoogleSignInAccount?>){
        return await result;
      }
      else{
        return result as GoogleSignInAccount;
      }


    }
    catch(e){
      print('Silent Sign in Failed : $e');
      return null;
    }

  }

  GoogleSignInAuthentication getAuthTokens(GoogleSignInAccount account){
    return account.authentication;
  }


  Future<String?> getAccessTokenForScope(List<String> scopes) async {

    await _ensureGoogleSignInInitialized();

    try{
      final authClient = _googleSignIn.authorizationClient;

      var authorization = await authClient.authorizationForScopes(scopes);

      if(authorization == null){
        authorization = await authClient.authorizeScopes(scopes);
      }

      return authorization?.accessToken;

    }
    catch(e){
      print('failed to get the access token for scopes : $e');
      return null;
    }

  }



}
