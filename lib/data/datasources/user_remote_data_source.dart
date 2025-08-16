import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDataSource {

  Future<User> logOrRegister();

}

class UserRemoteDataSourceImpl implements UserRemoteDataSource{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<User> logOrRegister() async{
    

  }

}