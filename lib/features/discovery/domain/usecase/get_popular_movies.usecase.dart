import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/core/usecase/usecase.abstract.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';

class GetPopularMoviesUseCase implements UseCase<List<MovieEntity>, int> {
  final DiscoveryRepository _repo;

  GetPopularMoviesUseCase(this._repo);

  @override
  Future<Either<Failure, List<MovieEntity>>> call(int page) =>
      _repo.getPopularMovies(page: page);
}
