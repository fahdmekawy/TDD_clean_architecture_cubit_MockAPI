import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/get_users.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

void main() {
  late GetUsers getUsersUseCase;
  late AuthenticationRepository mockAuthRepository;

  setUpAll(() {
    mockAuthRepository = MockAuthenticationRepository();
    getUsersUseCase = GetUsers(mockAuthRepository);
  });

  const testResponse = [User.empty()];
  test(
    'Should call [AuthRepo.getUsers] and return a list of [List<User>]',
    () async {
      // Arrange
      when(() => mockAuthRepository.getUsers()).thenAnswer(
        (_) async => Right(testResponse),
      );
      // Act
      final result = await getUsersUseCase();
      // Assert
      expect(result, equals(const Right<dynamic, List<User>>(testResponse)));
      verify(() => mockAuthRepository.getUsers()).called(1);
      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
