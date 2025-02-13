import 'package:dartz/dartz.dart';
import 'package:education_app/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:education_app/src/authentication/domain/usecases/create_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'authentication_repository.mock.dart';

void main() {
  late CreateUser createUserUseCase;
  late AuthenticationRepository mockAuthRepository;

  setUpAll(() {
    mockAuthRepository = MockAuthenticationRepository();
    createUserUseCase = CreateUser(mockAuthRepository);
  });

  final params = CreateUserParams.empty();
  test(
    "Should call the [AuthRepo.createUser]",
    () async {
      // Arrange
      when(
        () => mockAuthRepository.createUser(
          createAt: any(named: 'createAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // Act
      final result = await createUserUseCase(params);
      // Assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => mockAuthRepository.createUser(
          createAt: params.createAt,
          name: params.name,
          avatar: params.avatar,
        ),
      ).called(1);

      verifyNoMoreInteractions(mockAuthRepository);
    },
  );
}
