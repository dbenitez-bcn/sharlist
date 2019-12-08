class ServerException implements Exception {
  final String message;

  ServerException({this.message});
}

class UnsuccessfulGoogleSignInException extends ServerException {}

class UnsuccessfulFacebookSignInException extends ServerException {}

class FirebaseSignInException extends ServerException {}