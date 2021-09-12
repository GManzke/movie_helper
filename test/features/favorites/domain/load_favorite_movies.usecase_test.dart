import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart';
import 'package:movie_helper/features/favorites/domain/usecase/load_favorite_movies.usecase.dart';

import 'load_favorite_movies.usecase_test.mocks.dart';

@GenerateMocks([FavoritesRepository])
main() {
  late LoadFavoriteMoviesUseCase loadFavoriteMoviesUseCase;
  late MockFavoritesRepository repository;

  setUpAll(() {
    repository = MockFavoritesRepository();
    loadFavoriteMoviesUseCase = LoadFavoriteMoviesUseCase(repository);
  });

  final movieEntityList = [
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

  group('LoadFavoriteMoviesUseCase', () {
    test('Should return favorite movies list', () async {
      when(repository.loadFavoriteMovies())
          .thenAnswer((_) async => Right(movieEntityList));

      final res = await loadFavoriteMoviesUseCase();

      verify(repository.loadFavoriteMovies()).called(1);
      expect(res, equals(Right(movieEntityList)));
    });

    test('Should return cache failure', () async {
      when(repository.loadFavoriteMovies())
          .thenAnswer((_) async => const Left(kCacheFailure));

      final res = await loadFavoriteMoviesUseCase();

      verify(repository.loadFavoriteMovies()).called(1);
      expect(res, equals(const Left(kCacheFailure)));
    });
  });
}
