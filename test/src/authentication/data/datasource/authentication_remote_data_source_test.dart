import 'dart:convert';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource authenticationRemoteDataSource;

  setUp(() {
    client = MockClient();
    authenticationRemoteDataSource =
        AuthenticationRemoteDataSourceImplementation(client);
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test("Should complete successfully when the status code is 200 or 201",
        () async {
      // Arrange
      when(
        () => client.post(any(), body: any(named: "body")),
      ).thenAnswer(
        (_) async => http.Response('User created successfully', 201),
      );

      // Act
      final methodCall = authenticationRemoteDataSource.createUser;

      // Assert
      expect(
        methodCall(
          createAt: 'createAt',
          name: 'name',
          avatar: 'avatar',
        ),
        completes,
      );

      verify(
        () => client.post(
          Uri.https(kBaseUrl, kCreateUserEndPoint),
          body: jsonEncode(
            {
              'createAt': 'createAt',
              'name': 'name',
              'avatar': 'avatar',
            },
          ),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });

    test(
      'Should throw an [ApiException] when the status code is not 200 or 201',
      () {
        // Arrange
        when(
          () => client.post(any(), body: any(named: "body")),
        ).thenAnswer(
          (_) async => http.Response('Invalid email address', 400),
        );

        // Act
        final methodCall = authenticationRemoteDataSource.createUser;

        // Assert
        expect(
          methodCall(
            createAt: 'createAt',
            name: 'name',
            avatar: 'avatar',
          ),
          throwsA(
            ApiException(statusCode: 400, message: 'Invalid email address'),
          ),
        );
        verify(
          () => client.post(
            Uri.https(kBaseUrl, kCreateUserEndPoint),
            body: jsonEncode(
              {
                'createAt': 'createAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group("getUsers", () {
    final tUsers = [UserModel.empty()];
    test("Should return [List<User>] when the status code is 200", () async {
      // Arrange
      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
      );
      // Act
      final result = await authenticationRemoteDataSource.getUsers();
      // Assert
      expect(result, equals(tUsers));
      verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndPoint)))
          .called(1);
      verifyNoMoreInteractions(client);
    });
  });

  test("Should throw an [ApiException] when the status code is not 200",
      () async {
    // Arrange
    when(() => client.get(any())).thenAnswer(
      (_) async => http.Response('Server down', 500),
    );
    // Act
    final methodCall = authenticationRemoteDataSource.getUsers;
    // Assert
    expect(
      methodCall(),
      throwsA(
        ApiException(statusCode: 500, message: 'Server down'),
      ),
    );
    verify(() => client.get(Uri.https(kBaseUrl, kGetUsersEndPoint))).called(1);
    verifyNoMoreInteractions(client);
  });
}
