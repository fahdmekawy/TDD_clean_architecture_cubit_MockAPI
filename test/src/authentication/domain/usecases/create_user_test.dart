import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser createUserUseCase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    createUserUseCase = CreateUser(repository);
  });

  test(
    "Should call the [AuthRepo.createUser]",
    () async {
      // Arrange

      // Act

      // Assert
    },
  );
}
