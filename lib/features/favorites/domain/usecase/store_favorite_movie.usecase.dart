import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/core/usecase/usecase.abstract.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart';

class StoreFavoriteMovieUseCase extends UseCase<None, MovieEntity> {
  final FavoritesRepository _repository;

  StoreFavoriteMovieUseCase(this._repository);

  @override
  Future<Either<Failure, None>> call(MovieEntity param) =>
      _repository.storeFavoriteMovie(param);
}
