import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/data/enums/role.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';
import 'package:sharlist/domain/usecases/sign_in_with_facebook.dart';
import 'package:sharlist/domain/usecases/sign_in_with_google.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/bloc/auth/auth_state.dart';
import 'package:sharlist/presentation/bloc/auth/bloc.dart';

class MockSignInAnonymously extends Mock implements SignInAnonymously {}

class MockGoogleSignIn extends Mock implements SignInWithGoogle {}

class MockFacebookSignIn extends Mock implements SignInWithFacebook {}

void main() {
  AuthBloc bloc;
  MockSignInAnonymously mockSignInAnonymously;
  MockGoogleSignIn mockGoogleSignIn;
  MockFacebookSignIn mockFacebookSignIn;

  final user = SharlistUser(uid: 'uid', role: Role.user);

  setUp(() {
    mockSignInAnonymously = MockSignInAnonymously();
    mockGoogleSignIn = MockGoogleSignIn();
    mockFacebookSignIn = MockFacebookSignIn();

    bloc = AuthBloc(
        signInAnonymously: mockSignInAnonymously,
        signInWithGoogle: mockGoogleSignIn,
        signInWithFacebook: mockFacebookSignIn);
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
    test('should emit [Empty, Loading, Error] states when sign in unsuccessful',
        () async {
      // Arrange
      when(mockSignInAnonymously.call())
          .thenAnswer((_) async => Left(ServerFailure()));
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

  group('Google sign in', () {
    test(
        'should emit [Empty, Loading, Loaded] states when sign in successfully',
        () async {
      // Arrange
      when(mockGoogleSignIn.call()).thenAnswer((_) async => Right(user));
      final expected = [
        Empty(),
        Loading(),
        Loaded(user),
      ];
      // Act
      bloc.add(SignInWithGoogleEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test('should emit [Empty, Loading, Error] states when sign in unsuccessful',
        () async {
      // Arrange
      when(mockGoogleSignIn.call())
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: 'sign-in-failed'),
      ];
      // Act
      bloc.add(SignInWithGoogleEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test('should call google use case when SignIn Anonymously event emited',
        () async {
      // Arrange
      when(mockGoogleSignIn.call()).thenAnswer((_) async => Right(user));
      // Act
      bloc.add(SignInWithGoogleEvent());
      // Assert
      await untilCalled(mockGoogleSignIn.call());
    });
  });

  group('Facebook sign in', () {
    test(
        'should emit [Empty, Loading, Loaded] states when sign in successfully',
        () async {
      // Arrange
      when(mockFacebookSignIn.call()).thenAnswer((_) async => Right(user));
      final expected = [
        Empty(),
        Loading(),
        Loaded(user),
      ];
      // Act
      bloc.add(SignInWithFacebookEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test('should emit [Empty, Loading, Error] states when sign in unsuccessful',
        () async {
      // Arrange
      when(mockFacebookSignIn.call())
          .thenAnswer((_) async => Left(ServerFailure()));
      final expected = [
        Empty(),
        Loading(),
        Error(message: 'sign-in-failed'),
      ];
      // Act
      bloc.add(SignInWithFacebookEvent());
      // Assert
      expectLater(bloc.asBroadcastStream(), emitsInOrder(expected));
    });
    test('should call facebook use case when SignIn Anonymously event emited',
        () async {
      // Arrange
      when(mockFacebookSignIn.call()).thenAnswer((_) async => Right(user));
      // Act
      bloc.add(SignInWithFacebookEvent());
      // Assert
      await untilCalled(mockFacebookSignIn.call());
    });
  });
}
