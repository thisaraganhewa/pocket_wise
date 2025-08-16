import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class UserRemoteDataSource {

  Future<User> logOrRegister();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn  _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<User> logOrRegister() async{
    

  }

}