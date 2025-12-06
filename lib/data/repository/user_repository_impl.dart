import 'package:pocket_wise/data/datasources/user_remote_data_source.dart';
import 'package:pocket_wise/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {

  final UserRemoteDataSource _newsRemoteDataSource;

  UserRepositoryImpl(this._newsRemoteDataSource);

  @override
  Future<bool> logOrRegister() async {
    try{
      return await _newsRemoteDataSource.logOrRegister();
    }
    catch(e){
      throw Exception(e.toString());
    }
  }
}
