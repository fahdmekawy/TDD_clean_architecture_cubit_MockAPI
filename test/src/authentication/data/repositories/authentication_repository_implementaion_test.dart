import 'package:dartz/dartz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failure.dart';
import 'package:education_app/src/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:education_app/src/authentication/data/repositories/authentication_repository_implementaion.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repositoryImplementation;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSource();
    repositoryImplementation =
        AuthenticationRepositoryImplementation(remoteDataSource);
  });
  final tException =
      ApiException(statusCode: 500, message: "Unknown Error Occurred");
  group('createUser', () {
    final createAt = 'whatever.createAt';
    final name = 'whatever.name';
    final avatar = 'whatever.avatar';
    test(
        "Should call the [RemoteDataSource.createUser] and complete "
        "successfully when the call to the remote data source is successful",
        () async {
      // Arrange
      when(() => remoteDataSource.createUser(
          createAt: any(named: "createAt"),
          name: any(named: "name"),
          avatar: any(named: "avatar"))).thenAnswer((_) => Future.value());
      // Act
      final result = await repositoryImplementation.createUser(
          createAt: createAt, name: name, avatar: avatar);
      // Assert
      expect(result, equals(const Right(null)));
      verify(() => remoteDataSource.createUser(
          createAt: createAt, name: name, avatar: avatar)).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      "Should return a [ApiFailure] when the call to the remote data source ",
      () async {
        // Arrange
        when(() => remoteDataSource.createUser(
            createAt: any(named: "createAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"))).thenThrow(tException);

        // Act
        final result = await repositoryImplementation.createUser(
          createAt: createAt,
          name: name,
          avatar: avatar,
        );

        // Assert
        expect(
          result,
          equals(
            Left(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );
        verify(() => remoteDataSource.createUser(
            createAt: createAt, name: name, avatar: avatar)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group("getUsers", () {
    test(
        "Should call the [RemoteDataSource.getUsers] and return [List<Users>] when call to remote source is successful",
        () async {
      // Arrange
      when(() => remoteDataSource.getUsers()).thenAnswer(
        (_) async => [],
      );

      // Act
      final result = await repositoryImplementation.getUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());
      verify(() => remoteDataSource.getUsers()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      "Should return a [ApiFailure] when the call to the remote data source is unsuccessful",
      () async {
        // Arrange
        when(() => remoteDataSource.getUsers()).thenThrow(tException);
        // Act
        final result = await repositoryImplementation.getUsers();
        // Assert
        expect(
          result,
          equals(
            Left(
              ApiFailure(
                  message: tException.message,
                  statusCode: tException.statusCode),
            ),
          ),
        );
        verify(() => remoteDataSource.getUsers()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
