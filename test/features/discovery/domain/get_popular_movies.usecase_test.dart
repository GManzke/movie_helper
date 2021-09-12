import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';

import 'get_popular_movies.usecase_test.mocks.dart';

@GenerateMocks([DiscoveryRepository])
main() {
  late MockDiscoveryRepository repository;
  late GetPopularMoviesUseCase getPopularMoviesUseCase;

  setUp(() {
    repository = MockDiscoveryRepository();
    getPopularMoviesUseCase = GetPopularMoviesUseCase(repository);
  });

  group('GetPopularMoviesUseCase', () {
    test('Should return Right with the movie List', () async {
      final movieList = [
        const MovieEntity(
            genres: [1],
            voteAverage: 10.0,
            overview: 'Very scary movie',
            title: 'Jane Doe',
            id: 666),
        const MovieEntity(
            genres: [1],
            voteAverage: 3.0,
            overview: 'Not so scary movie',
            title: 'Halloween (2018)',
            id: 666)
      ];

      when(repository.getPopularMovies(page: 1))
          .thenAnswer((_) async => Right(movieList));

      final res = await getPopularMoviesUseCase(1);

      expect(res, equals(Right(movieList)));
    });

    test('Should return Left with Generic Failure', () async {
      when(repository.getPopularMovies(page: 1))
          .thenAnswer((_) async => const Left(kGenericFailure));

      final res = await getPopularMoviesUseCase(1);

      expect(res, equals(const Left(kGenericFailure)));
    });

    test('Should return Left with Not Found Failure', () async {
      when(repository.getPopularMovies(page: 1))
          .thenAnswer((_) async => const Left(kNotFoundFailure));

      final res = await getPopularMoviesUseCase(1);

      expect(res, equals(const Left(kNotFoundFailure)));
    });
  });
}
