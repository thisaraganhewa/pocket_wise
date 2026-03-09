
import 'package:get_it/get_it.dart';
import 'package:pocket_wise/features/auth/data/datasources/user_remote_data_source.dart';
import 'package:pocket_wise/features/auth/data/repository/user_repository_impl.dart';
import 'package:pocket_wise/features/auth/domain/repositories/user_repository.dart';
import 'package:pocket_wise/features/auth/domain/usecases/sign_in_with_google_use_case.dart';

final sl = GetIt.instance;


Future<void> init() async{

  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl());
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<SignInWithGoogleUseCase>(() => SignInWithGoogleUseCase(sl()));

}