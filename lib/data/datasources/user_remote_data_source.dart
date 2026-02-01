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
  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get currentUser => _currentUser;

  bool get isSignedIn => _currentUser != null;  

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


// Scope Management
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

  Future<void> signIn() async {
    try{
      _currentUser = await signInWithGoogle();
      
    }
    catch(e)
    {
      _currentUser = null;
      rethrow;
    }
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    
  }

  Future<UserCredential> signUpWithGoogleFirebase() async {
    
    await _ensureGoogleSignInInitialized();

    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate(
      scopeHint: ['email'],
    );

    final authClient = _googleSignIn.authorizationClient;
    final authorization = await authClient.authorizationForScopes(['email']);
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: authorization?.accessToken,
      idToken: googleAuth.idToken
    );

    final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

    _currentUser = googleUser;

    return userCredential;

  }



}
