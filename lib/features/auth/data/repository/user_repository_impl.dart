import 'package:pocket_wise/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:pocket_wise/features/auth/domain/entities/user_entity.dart';
import 'package:pocket_wise/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource _newsRemoteDataSource;

  UserRepositoryImpl(this._newsRemoteDataSource);

  @override
  Future<UserEntity?> signInWithGoogle() async {
    
    final userDetails = await _newsRemoteDataSource.signInWithGoogle();

    if(userDetails == null) return null;

    return userDetails;

  }
}
