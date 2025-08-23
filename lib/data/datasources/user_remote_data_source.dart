import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRemoteDataSource {

  Future<User?> logOrRegister();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn  _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? clientId;
  String? serverClientId;

  @override
  Future<User?> logOrRegister() async{
    
    try{

      final GoogleSignInAccount? googleUser;

      unawaited(_googleSignIn.initialize(
        clientId: clientId,
        serverClientId: serverClientId
      ).then((_){
        _googleSignIn.authenticationEvents
          .listen()
          .onError();
      }));
      

    }
     catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }

  }

  

}