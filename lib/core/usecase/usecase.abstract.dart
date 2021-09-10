import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';

abstract class UseCase<Data, Param> {
  Future<Either<Failure, Data>> call(Param param);
}
