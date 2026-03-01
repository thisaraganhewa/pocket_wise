import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_wise/domain/entities/user_entity.dart';
import 'package:pocket_wise/domain/repositories/user_repository.dart';


class SignInWithGoogleUseCase {

  final UserRepository _userRepository;

  SignInWithGoogleUseCase(this._userRepository);

  Future<UserEntity?> logOrRegister() async{
    return await _userRepository.signInWithGoogle();
  }

}