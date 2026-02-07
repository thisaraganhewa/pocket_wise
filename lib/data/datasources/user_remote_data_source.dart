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
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  UserRemoteDataSource({
    this.auth,
    this.googleSignIn
  })

  Future<bool> logOrRegister();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  
 

  @override
  Future<bool> logOrRegister() async {
    _initializeGoogleSignIn();
    return _isGoogleSignInInitialized;
  }

  


}
