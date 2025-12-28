
import 'package:get_it/get_it.dart';
import 'package:pocket_wise/data/datasources/user_remote_data_source.dart';
import 'package:pocket_wise/data/repository/user_repository_impl.dart';
import 'package:pocket_wise/domain/repositories/user_repository.dart';
import 'package:pocket_wise/domain/usecases/user.dart';

final sl = GetIt.instance;


Future<void> init() async{

  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<User>(() => User(sl()));

}