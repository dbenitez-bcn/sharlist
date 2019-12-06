import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]): super();

  @override
  List<Object> get props => [List];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({this.message});
}

class UnsuccessfulGoogleSignInFailure extends ServerFailure {}

class FirebaseSignInFailure extends ServerFailure {}