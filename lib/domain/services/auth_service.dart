import 'package:dartz/dartz.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';

abstract class AuthService {
  Future <Either<Failure, SharlistUser>> getUserUsingGoogle(String email, String password);
  Future <Either<Failure, SharlistUser>> getUserUsingFacebook(String email, String password);
  Future <Either<Failure, SharlistUser>> getAnonymousUser();
}