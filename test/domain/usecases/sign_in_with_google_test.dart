import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/usecases/sign_in_with_google.dart';

import '../../core/mocks/mock_auth_service.dart';

void main() {
  SignInWithGoogle usecase;
  MockAuthService mockAuthService;
  final user = SharlistUser(uid: 'uid', role: Role.user);

  setUp(() {
    mockAuthService = MockAuthService();
    usecase = SignInWithGoogle(mockAuthService);
  });

  test('should sign in with users google account', () async {
    // Arrange
    when(mockAuthService.getUserUsingGoogle())
        .thenAnswer((_) async => Right(user));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(user));
    verify(mockAuthService.getUserUsingGoogle());
    verifyNoMoreInteractions(mockAuthService);
  });

  test('should return a UnsuccessfulGoogleSignInFailure when google sign in fails', () async {
    // Arrange
    when(mockAuthService.getUserUsingGoogle())
        .thenAnswer((_) async => Left(UnsuccessfulGoogleSignInFailure()));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Left(UnsuccessfulGoogleSignInFailure()));
    verify(mockAuthService.getUserUsingGoogle());
    verifyNoMoreInteractions(mockAuthService);
  });

  test('should return a FirebaseSignInFailure when firebase sign in fails', () async {
    // Arrange
    when(mockAuthService.getUserUsingGoogle())
        .thenAnswer((_) async => Left(FirebaseSignInFailure()));

    // Act
    final result = await usecase();

    // Assert
    expect(result, Left(FirebaseSignInFailure()));
    verify(mockAuthService.getUserUsingGoogle());
    verifyNoMoreInteractions(mockAuthService);
  });
}
