import 'package:dartz/dartz.dart';
import 'package:sharlist/core/error/failures.dart';

abstract class AuthService {
  Future <Either<Failure, String>> getGoogleUid(String email, String password);
  Future <Either<Failure, String>> getFacebookUid(String email, String password);
  Future <Either<Failure, String>> getAnonymousUid();
}