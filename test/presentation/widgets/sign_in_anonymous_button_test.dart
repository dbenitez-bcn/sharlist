import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sharlist/core/injection_container.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';
import 'package:sharlist/presentation/bloc/auth/auth_bloc.dart';
import 'package:sharlist/presentation/widgets/sign_in_anonymous_button.dart';

import '../../core/test_app.dart';
import '../bloc/auth/auth_bloc_test.dart';

class SignInAnonymouslyMock extends Mock implements SignInAnonymously {
  int called = 0;

  call() {
    called++;
    return null;
  }
}

class AuthBlocMock extends AuthBloc {}

void main() {
  setUp(() {
    sl.registerLazySingleton<SignInAnonymously>(() => SignInAnonymouslyMock());
  });
  testWidgets('should call SignInAnonymously when button is tap',
      (WidgetTester tester) async {
    // Arrange
    SignInAnonymouslyButton widget = SignInAnonymouslyButton();
    BlocProvider provider = BlocProvider<AuthBloc>(
        builder: (_) => AuthBloc(
            signInAnonymously: sl<SignInAnonymously>(),
            signInWithGoogle: MockGoogleSignIn(),
            signInWithFacebook: MockFacebookSignIn()),
        child: Center(child: widget));
    // Act
    await tester.pumpWidget(TestApp(provider));
    await tester.tap(find.byKey(Key('signInAnonymouslyButton')));
    final SignInAnonymouslyMock useCase = sl<SignInAnonymously>();
    // Assert
    expect(find.text('Acceder sin iniciar sesion'), findsOneWidget);

    expectLater(useCase.called, 1);
  });
}
