import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/services/auth_service.dart';

class SignInWithFacebook {
  final AuthService service;

  SignInWithFacebook(this.service);

  Future<Either<Failure, SharlistUser>> call({
    @required String email,
    @required String password,
  }) async {
    return await service.getUserUsingFacebook(email, password);
  }
}