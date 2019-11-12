import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/data/models/sharlist_user_model.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final testUser = SharlistUserModel(uid: 'uid', role: Role.user);
  final testAdmin = SharlistUserModel(uid: 'uid', role: Role.admin);
  final testDeveloper = SharlistUserModel(uid: 'uid', role: Role.developer);

  test('should be a subclass a SharlistUser entity', () async {
    // Assert
    expect(testUser, isA<SharlistUser>());
  });

  group('fromJson', () {
    test('should return a valid json for user role', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('sharlist_user_user.json'));

      // Act
      final result = SharlistUserModel.fromJson(jsonMap);

      // Assert
      expect(result, testUser);
    });

    test('should return a valid json for admin role', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('sharlist_user_admin.json'));

      // Act
      final result = SharlistUserModel.fromJson(jsonMap);

      // Assert
      expect(result, testAdmin);
    });

    test('should return a valid json for developer role', () async {
      // Arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('sharlist_user_developer.json'));

      // Act
      final result = SharlistUserModel.fromJson(jsonMap);

      // Assert
      expect(result, testDeveloper);
    });
  });
  
  group('toJson', () {
    test('should conver a user user to json', () async {
      // Act
      final result = testUser.toJson();
      final expected = {
        'uid': 'uid',
        'role': 'user'
      };

      // Assert
      expect(result, expected);
    });

    test('should conver a user developer to json', () async {
      // Act
      final result = testDeveloper.toJson();
      final expected = {
        'uid': 'uid',
        'role': 'developer'
      };

      // Assert
      expect(result, expected);
    });
    
    test('should conver a user admin to json', () async {
      // Act
      final result = testAdmin.toJson();
      final expected = {
        'uid': 'uid',
        'role': 'admin'
      };

      // Assert
      expect(result, expected);
    });
  });
}
