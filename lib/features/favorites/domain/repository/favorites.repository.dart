import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<MovieEntity>>> loadFavoriteMovies();

  Future<Either<Failure, None>> storeFavoriteMovie(MovieEntity movie);
}
