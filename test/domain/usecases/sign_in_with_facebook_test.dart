import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/domain/usecases/sign_in_with_facebook.dart';

import '../../core/mocks/mock_auth_service.dart';

void main() {
  SignInWithFacebook usecase;
  MockAuthService mockAuthService;
  final uid = 'userIdTest';
  final email = 'test@example.com';
  final password = 'testPassword';

  setUp(() {
    mockAuthService = MockAuthService();
    usecase = SignInWithFacebook(mockAuthService);
  });

  test('should sign in with users facebook account', () async {
    // Arrange
    when(mockAuthService.getFacebookUid(any, any))
        .thenAnswer((_) async => Right(uid));

    // Act
    final result = await usecase(email: email, password: password);

    // Assert
    expect(result, Right(uid));
    verify(mockAuthService.getFacebookUid(email, password));
    verifyNoMoreInteractions(mockAuthService);
  });

}