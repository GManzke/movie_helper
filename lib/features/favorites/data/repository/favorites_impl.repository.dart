import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/data/datasource/favorites.datasource.dart';
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesDataSource _dataSource;

  FavoritesRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> loadFavoriteMovies() async {
    try {
      return Right(await _dataSource.fetchFavoriteMovies());
    } catch (e) {
      return const Left(kCacheFailure);
    }
  }

  @override
  Future<Either<Failure, None>> storeFavoriteMovie(MovieEntity movie) async {
    try {
      await _dataSource.storeFavoriteMovie(MovieModel(
          voteAverage: movie.voteAverage,
          posterPath: movie.posterPath,
          overview: movie.overview,
          genres: movie.genres,
          title: movie.title,
          id: movie.id));

      return const Right(None());
    } catch (e) {
      return const Left(kCacheFailure);
    }
  }
}
