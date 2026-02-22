
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pocket_wise/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> signInWithGoogle();
}