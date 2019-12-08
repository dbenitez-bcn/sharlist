import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class SignInAnonymouslyEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignInWithGoogleEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class SignInWithFacebookEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}