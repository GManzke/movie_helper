import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/movie_list/domain/entities/movie.entity.dart';

abstract class MovieListRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies();
}
