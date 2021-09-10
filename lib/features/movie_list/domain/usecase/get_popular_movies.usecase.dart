import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/core/usecase/usecase.abstract.dart';
import 'package:movie_helper/features/movie_list/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/movie_list/domain/repository/movie_list.repository.dart';

class GetPopularMoviesUseCase implements UseCase<List<MovieEntity>, None?> {
  final MovieListRepository _repo;

  GetPopularMoviesUseCase(this._repo);

  @override
  Future<Either<Failure, List<MovieEntity>>> call([None? _]) =>
      _repo.getPopularMovies();
}
