import 'package:dartz/dartz.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/services/auth_service.dart';

class SignInWithGoogle {
  final AuthService service;

  SignInWithGoogle(this.service);

  Future<Either<Failure, SharlistUser>> call() async {
    return await service.getUserUsingGoogle();
  }
}
