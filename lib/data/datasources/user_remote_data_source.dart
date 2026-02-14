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
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  UserRemoteDataSourceImpl({
    required this.auth,
    required this.googleSignIn
  });

  @override
  Future<bool> logOrRegister() async {
    try{
      final GoogleSignInAccount googleUser = await googleSignIn.signIn()
    }
    catch(e){
      throw Exception("Google log in failed in user_remote_data_source: $e");
    }
  }
}
