import 'dart:convert';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:education_app/src/authentication/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test("Should be a subclass of [User] Entity", () {
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture('user.json');

  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test("Should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test("Should return a [UserModel] with the right data", () {
      // Act
      final result = UserModel.fromJson(tJson);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("Should return a [Map] with the right data", () {
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("Should return a [JSON] string with the right data", () {
      // Act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "0",
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar"
      });
      // Assert
      expect(result, equals(tJson));
    });
  });

  group("copyWith", () {
    test("Should return a [UserModel] with different data", () {
      // Arrange
      // Act
      final result = tModel.copyWith(name: 'Paul');
      // Assert
      expect(result.name, equals('Paul'));
    });
  });
}
