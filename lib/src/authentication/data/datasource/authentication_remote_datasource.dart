import 'dart:convert';

import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

class AuthenticationRemoteDataSourceImplementation
    implements AuthenticationRemoteDataSource {
  const AuthenticationRemoteDataSourceImplementation(this._client);

  final http.Client _client;

  @override
  Future<void> createUser(
      {required String createAt,
      required String name,
      required String avatar}) async {
    try {
      final response = await _client.post(
        Uri.https(kBaseUrl, kCreateUserEndPoint),
        body: jsonEncode(
          {
            'createAt': createAt,
            'name': name,
            'avatar': avatar,
          },
        ),
        headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
            statusCode: response.statusCode, message: response.body);
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(kBaseUrl, kGetUsersEndPoint),
      );
      if (response.statusCode != 200) {
        throw ApiException(
            statusCode: response.statusCode, message: response.body);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
