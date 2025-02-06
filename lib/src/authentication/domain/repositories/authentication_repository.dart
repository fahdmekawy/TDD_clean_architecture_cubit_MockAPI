import 'package:education_app/src/authentication/domain/entities/user.dart';
import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String createAt,
    required String name,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
