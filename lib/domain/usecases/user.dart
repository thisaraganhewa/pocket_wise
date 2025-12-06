import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_wise/data/datasources/user_remote_data_source.dart';

class User {

  final UserRemoteDataSourceImpl _userRepository;

  User(this._userRepository);

  Future<bool> logOrRegister() async{
    return await _userRepository.logOrRegister();
  }

}