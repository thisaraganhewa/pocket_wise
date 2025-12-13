
import 'package:get_it/get_it.dart';
import 'package:pocket_wise/data/datasources/user_remote_data_source.dart';
import 'package:pocket_wise/domain/usecases/user.dart';

final sl = GetIt.instance;


Future<void> init() async{

  sl.registerLazySingleton<User>(() => User(UserRemoteDataSourceImpl()));

}