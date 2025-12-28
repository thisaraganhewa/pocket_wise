import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_wise/domain/repositories/user_repository.dart';


class User {

  final UserRepository _userRepository;

  User(this._userRepository);

  Future<bool> logOrRegister() async{
    return await _userRepository.logOrRegister();
  }

}