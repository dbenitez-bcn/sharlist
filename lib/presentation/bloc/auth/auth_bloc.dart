import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/domain/usecases/sign_in_anonymously.dart';
import 'package:sharlist/domain/usecases/sign_in_with_google.dart';
import './bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInAnonymously signInAnonymously;
  final SignInWithGoogle signInWithGoogle;

  AuthBloc({@required this.signInAnonymously, @required this.signInWithGoogle})
      : assert(signInAnonymously != null),
        assert(signInWithGoogle != null);

  @override
  AuthState get initialState => Empty();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is SignInAnonymouslyEvent) {
      yield Loading();
      final response = await signInAnonymously();
      yield response.fold(_fail, _sendUser);
    } else if (event is SignInWithGoogleEvent) {
      yield Loading();
      final response = await signInWithGoogle();
      yield response.fold(_fail, _sendUser);
    }
  }

  AuthState _sendUser(user) => Loaded(user);

  AuthState _fail(failure) => Error(message: 'sign-in-failed');
}
