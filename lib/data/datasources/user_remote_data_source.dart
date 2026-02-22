import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_wise/domain/entities/user_entity.dart';
import 'package:pocket_wise/firebase_options.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<UserEntity?> signInWithGoogle();
  User? getCurrentUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


  UserRemoteDataSourceImpl();

  @override
  Future<UserEntity?> signInWithGoogle() async {

    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    if(gUser == null) return null;

    final GoogleSignInAuthentication gAuth  = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken
    );

    return await _firebaseAuth.signInWithCredential(credential);

  }


  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

}
