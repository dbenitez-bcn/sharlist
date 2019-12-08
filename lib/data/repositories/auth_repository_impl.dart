import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:sharlist/core/error/failures.dart';
import 'package:sharlist/core/error/exceptions.dart';
import 'package:sharlist/data/datasources/user_remote_data_source.dart';
import 'package:sharlist/domain/entities/sharlist_user.dart';
import 'package:sharlist/domain/services/auth_service.dart';

class AuthRepositoryImpl implements AuthService {
  final UserRemoteDataSource dataSource;
  final Either<Failure, SharlistUser> firebaseFailure =
      Left(FirebaseSignInFailure());

  AuthRepositoryImpl({@required this.dataSource});

  @override
  Future<Either<Failure, SharlistUser>> getAnonymousUser() async {
    try {
      return Right(await dataSource.getAnonymousUser());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, SharlistUser>> getUserUsingFacebook() async {
    try {
      return Right(await dataSource.getUserUsingFacebook());
    } on UnsuccessfulFacebookSignInException {
      return Left(UnsuccessfulFacebookSignInFailure());
    } on FirebaseSignInException {
      return firebaseFailure;
    }
  }

  @override
  Future<Either<Failure, SharlistUser>> getUserUsingGoogle() async {
    try {
      return Right(await dataSource.getUserUsingGoogle());
    } on UnsuccessfulGoogleSignInException {
      return Left(UnsuccessfulGoogleSignInFailure());
    } on FirebaseSignInException {
      return firebaseFailure;
    }
  }
}
