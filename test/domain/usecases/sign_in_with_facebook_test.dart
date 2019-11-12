import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/usecases/sign_in_with_facebook.dart';

import '../../core/mocks/mock_auth_service.dart';

void main() {
  SignInWithFacebook usecase;
  MockAuthService mockAuthService;
  final user = SharlistUser(uid: 'uid', role: Role.user);
  final email = 'test@example.com';
  final password = 'testPassword';

  setUp(() {
    mockAuthService = MockAuthService();
    usecase = SignInWithFacebook(mockAuthService);
  });

  test('should sign in with users facebook account', () async {
    // Arrange
    when(mockAuthService.getUserUsingFacebook(any, any))
        .thenAnswer((_) async => Right(user));

    // Act
    final result = await usecase(email: email, password: password);

    // Assert
    expect(result, Right(user));
    verify(mockAuthService.getUserUsingFacebook(email, password));
    verifyNoMoreInteractions(mockAuthService);
  });
}
