import 'package:education_app/src/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_implementaion.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/create_user.dart';
import 'package:education_app/src/authentication/domain/usecases/get_users.dart';
import 'package:education_app/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // App Logic
  sl
    ..registerFactory(
      () => AuthenticationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )
    // Use Cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    // Repos
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))
    // Data Sources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImplementation(sl()))
    // External Dependencies
    ..registerLazySingleton((http.Client.new));
}
