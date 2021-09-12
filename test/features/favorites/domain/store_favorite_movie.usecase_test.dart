import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/domain/usecase/store_favorite_movie.usecase.dart';

import 'load_favorite_movies.usecase_test.mocks.dart';

main() {
  late StoreFavoriteMovieUseCase storeFavoriteMovieUseCase;
  late MockFavoritesRepository repository;

  setUpAll(() {
    repository = MockFavoritesRepository();
    storeFavoriteMovieUseCase = StoreFavoriteMovieUseCase(repository);
  });

  const movieEntity = MovieEntity(
      genres: [1],
      voteAverage: 10.0,
      overview: 'Very scary movie',
      title: 'Jane Doe',
      id: 666);

  group('StoreFavoriteMovieUseCase', () {
    test('Should successfully store favorite movie', () async {
      when(repository.storeFavoriteMovie(movieEntity))
          .thenAnswer((_) async => const Right(None()));

      final res = await storeFavoriteMovieUseCase(movieEntity);

      verify(repository.storeFavoriteMovie(movieEntity)).called(1);
      expect(res, equals(const Right(None())));
    });

    test('Should return cache failure', () async {
      when(repository.storeFavoriteMovie(movieEntity))
          .thenAnswer((_) async => const Left(kCacheFailure));

      final res = await storeFavoriteMovieUseCase(movieEntity);

      verify(repository.storeFavoriteMovie(movieEntity)).called(1);
      expect(res, equals(const Left(kCacheFailure)));
    });
  });
}
