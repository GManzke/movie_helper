import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

abstract class DiscoveryRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
