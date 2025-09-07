import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_wise/firebase_options.dart';

abstract class UserRemoteDataSource {
  Future<User?> logOrRegister();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  late final GoogleSignInAccount? googleUser;
  bool _isAuthorized = false;
  String _contactText = '';
  String _errorMessage = '';
  String _serverAuthCode = '';
  final List<String> scopes = <String>[
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  @override
  Future<User?> logOrRegister() async {
    String? clientId = firebaseOptions.iosClientId;
    String? serverClientId = firebaseOptions.iosClientId;
    try {
      unawaited(
        _googleSignIn
            .initialize(clientId: clientId, serverClientId: serverClientId)
            .then((_) {
              _googleSignIn.authenticationEvents.listen().onError();
              _googleSignIn.attemptLightweightAuthentication();
            }),
      );
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);

    googleUser = user;
    _isAuthorized = authorization != null;
    _errorMessage = "";

    if(googleUser != null && authorization != null){

    }

  }

  Future<void> _handleAuthenticationError(Object e){
    googleUser = null;
    _isAuthorized = false;
    _errorMessage = e is GoogleSignInException ? 
  }

  String _errorMessageFromSignInException(GoogleSignInException e){
    
  }

}
