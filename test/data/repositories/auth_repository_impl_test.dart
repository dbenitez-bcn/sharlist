import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/error/exceptions.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/data/datasources/user_remote_data_source.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/data/models/sharlist_user_model.dart';
import 'package:sharlist/data/repositories/auth_repository_impl.dart';

class MockUserRemoteDataSource extends Mock implements UserRemoteDataSource {}

void main() {
  AuthRepositoryImpl repository;
  MockUserRemoteDataSource mockDataSource;
  SharlistUserModel user;

  setUp(() {
    mockDataSource = MockUserRemoteDataSource();
    repository = AuthRepositoryImpl(dataSource: mockDataSource);
    user = SharlistUserModel(uid: 'uid', role: Role.user);
  });

  group('Google sign in way', () {
    test('should return a sharlist user when the sign in is successfuly',
            () async {
          // Arrange
          when(mockDataSource.getUserUsingGoogle())
              .thenAnswer((_) async => user);
          // Act
          final result = await repository.getUserUsingGoogle();
          // Assert
          verify(mockDataSource.getUserUsingGoogle());
          expect(result, equals(Right(user)));
        });
    test('should return a failure when bad server response', () async {
      // Arrange
      when(mockDataSource.getUserUsingGoogle()).thenThrow(ServerException());

      // Act
      final result = await repository.getUserUsingGoogle();

      // Assert
      verify(mockDataSource.getUserUsingGoogle());
      verifyNoMoreInteractions(mockDataSource);
      expect(result, equals((Left(ServerFailure()))));
    });
  });

  group('Facebook sign in way', () {
    test('should return a sharlist user when the sign in is successfuly',
            () async {
          // Arrange
          when(mockDataSource.getUserUsingFacebook())
              .thenAnswer((_) async => user);
          // Act
          final result = await repository.getUserUsingFacebook();
          // Assert
          verify(mockDataSource.getUserUsingFacebook());
          expect(result, equals(Right(user)));
        });
    test('should return a failure when bad server response', () async {
      // Arrange
      when(mockDataSource.getUserUsingFacebook()).thenThrow(ServerException());

      // Act
      final result = await repository.getUserUsingFacebook();

      // Assert
      verify(mockDataSource.getUserUsingFacebook());
      verifyNoMoreInteractions(mockDataSource);
      expect(result, equals((Left(ServerFailure()))));
    });
  });

  group('Anonymous sign in way', () {
    test('should return a sharlist user when the sign in is successfuly',
            () async {
          // Arrange
          when(mockDataSource.getAnonymousUser())
              .thenAnswer((_) async => user);
          // Act
          final result = await repository.getAnonymousUser();
          // Assert
          verify(mockDataSource.getAnonymousUser());
          expect(result, equals(Right(user)));
        });
    test('should return a failure when bad server response', () async {
      // Arrange
      when(mockDataSource.getAnonymousUser()).thenThrow(ServerException());

      // Act
      final result = await repository.getAnonymousUser();

      // Assert
      verify(mockDataSource.getAnonymousUser());
      verifyNoMoreInteractions(mockDataSource);
      expect(result, equals((Left(ServerFailure()))));
    });
  });
}
