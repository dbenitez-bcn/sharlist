import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/domain/services/auth_service.dart';

class SignInWithGoogle {
  final AuthService service;

  SignInWithGoogle(this.service);

  Future<Either<Failure, String>> call({
    @required String email,
    @required String password,
  }) async {
    return await service.getGoogleUid(email, password);
  }
}
