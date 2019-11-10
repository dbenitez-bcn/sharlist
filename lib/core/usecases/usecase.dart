import 'package:dartz/dartz.dart';
import 'package:sharlist/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(any);
}