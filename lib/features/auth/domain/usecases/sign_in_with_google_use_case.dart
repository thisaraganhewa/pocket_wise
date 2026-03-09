import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_wise/features/auth/domain/entities/user_entity.dart';
import 'package:pocket_wise/features/auth/domain/repositories/user_repository.dart';


class SignInWithGoogleUseCase {

  final UserRepository _userRepository;

  SignInWithGoogleUseCase(this._userRepository);

  Future<UserEntity?> logOrRegister() async{
    return await _userRepository.signInWithGoogle();
  }

}