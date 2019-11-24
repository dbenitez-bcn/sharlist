import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/bloc/auth/auth_state.dart';
import 'package:sharlist/presentation/bloc/auth/bloc.dart';

class MockSignInAnonymously extends Mock implements SignInAnonymously {}

void main() {
  AuthBloc bloc;
  MockSignInAnonymously mockSignInAnonymously;
  final user = SharlistUser(uid: 'uid', role: Role.user);

  setUp(() {
    mockSignInAnonymously = MockSignInAnonymously();
    bloc = AuthBloc(signInAnonymously: mockSignInAnonymously);
  });

  test('Initial state should be Empty', () {
    expect(bloc.initialState, equals(Empty()));
  });

  group('Anonymous sign in', () {
    test(
        'should emit [Empty, Loading, Loaded] states when sign in successfully',
        () async {
      // Arrange
      when(mockSignInAnonymously.call()).thenAnswer((_) async => Right(user));
      final expected = [
        Empty(),
        Loading(),
        Loaded(user),
      ];
      // Act
      bloc.add(SignInAnonymouslyEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test(
        'should emit [Empty, Loading, Error] states when sign in unsuccessful',
        () async {
      // Arrange
      when(mockSignInAnonymously.call()).thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: 'sign-in-failed'),
      ];
      // Act
      bloc.add(SignInAnonymouslyEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test('should call anonymous use case when SignIn Anonymously event emited',
        () async {
      // Arrange
      when(mockSignInAnonymously.call()).thenAnswer((_) async => Right(user));
      // Act
      bloc.add(SignInAnonymouslyEvent());
      // Assert
      await untilCalled(mockSignInAnonymously.call());
    });
  });
}
