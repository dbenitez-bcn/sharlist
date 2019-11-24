import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class Empty extends AuthState {
  @override
  List<Object> get props => [];
}

class Loading extends AuthState {
  @override
  List<Object> get props => [];
}

class Loaded extends AuthState {
  final SharlistUser user;

  Loaded(this.user);

  @override
  List<Object> get props => [user];
}

class Error extends AuthState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}