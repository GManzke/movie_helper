import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/data/datasource/favorites.datasource.dart';
import 'package:movie_helper/features/favorites/data/repository/favorites_impl.repository.dart';

import 'favorites_impl.repository_test.mocks.dart';

@GenerateMocks([FavoritesDataSource])
main() {
  late FavoritesRepositoryImpl favoritesRepositoryImpl;
  late MockFavoritesDataSource dataSource;

  final List<MovieModel> movieModelList = [
    const MovieModel(
        genres: [1],
        voteAverage: 10.0,
        overview: 'Very scary movie',
        title: 'Jane Doe',
        id: 666),
    const MovieModel(
        genres: [1],
        voteAverage: 3.0,
        overview: 'Not so scary movie',
        title: 'Halloween (2018)',
        id: 666)
  ];
  final List<MovieEntity> movieEntityList = movieModelList;

  const movieEntity = MovieEntity(
      genres: [1],
      voteAverage: 10.0,
      overview: 'Very scary movie',
      title: 'Jane Doe',
      id: 666);

  const movieModel = MovieModel(
      genres: [1],
      voteAverage: 10.0,
      overview: 'Very scary movie',
      title: 'Jane Doe',
      id: 666);

  setUpAll(() {
    dataSource = MockFavoritesDataSource();
    favoritesRepositoryImpl = FavoritesRepositoryImpl(dataSource);
  });

  group('loadFavoriteMovies', () {
    test('Should return favorite movies list', () async {
      when(dataSource.fetchFavoriteMovies())
          .thenAnswer((_) async => movieModelList);

      final res = await favoritesRepositoryImpl.loadFavoriteMovies();

      verify(dataSource.fetchFavoriteMovies());
      expect(res, equals(Right(movieEntityList)));
    });

    test('Should return cache failure', () async {
      when(dataSource.fetchFavoriteMovies()).thenThrow(Exception());

      final res = await favoritesRepositoryImpl.loadFavoriteMovies();

      verify(dataSource.fetchFavoriteMovies());
      expect(res, equals(const Left(kCacheFailure)));
    });
  });

  group('storeFavoriteMovie', () {
    test('Should return favorite movies list', () async {
      when(dataSource.storeFavoriteMovie(movieModel))
          .thenAnswer((_) async => movieModelList);

      final res = await favoritesRepositoryImpl.storeFavoriteMovie(movieEntity);

      verify(dataSource.storeFavoriteMovie(movieModel));
      expect(res, equals(const Right(None())));
    });

    test('Should return cache failure', () async {
      when(dataSource.storeFavoriteMovie(movieModel)).thenThrow(Exception());

      final res = await favoritesRepositoryImpl.storeFavoriteMovie(movieEntity);

      verify(dataSource.storeFavoriteMovie(movieModel));
      expect(res, equals(const Left(kCacheFailure)));
    });
  });
}
