import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';

import '../../core/mocks/mock_auth_service.dart';

void main() {
  SignInAnonymously usecase;
  MockAuthService mockAuthService;
  final uid = 'userIdTest';

  setUp(() {
    mockAuthService = MockAuthService();
    usecase = SignInAnonymously(mockAuthService);
  });

  test('should sign in with an anonymous uid', () async {
    // Arrange
    when(mockAuthService.getAnonymousUid()).thenAnswer((_) async => Right(uid));
    // Act
    final result = await usecase();

    // Assert
    expect(result, Right(uid));
    verify(mockAuthService.getAnonymousUid());
    verifyNoMoreInteractions(mockAuthService);
  });
}
