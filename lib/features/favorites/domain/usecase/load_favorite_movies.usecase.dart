import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/core/usecase/usecase.abstract.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart';

class LoadFavoriteMoviesUseCase extends UseCase<List<MovieEntity>, void> {
  final FavoritesRepository _repository;

  LoadFavoriteMoviesUseCase(this._repository);

  @override
  Future<Either<Failure, List<MovieEntity>>> call([void param]) =>
      _repository.loadFavoriteMovies();
}
