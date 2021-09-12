import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/datasource/storage.adapter.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';
import 'package:movie_helper/features/favorites/data/datasource/favorites.datasource.dart';

import 'favorites.datasource_test.mocks.dart';

@GenerateMocks([StorageAdapter])
main() {
  late FavoritesDataSourceImpl favoritesDataSourceImpl;
  late MockStorageAdapter storageAdapter;

  const movieModel = MovieModel(
      posterPath: '/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg',
      genres: [1, 2],
      voteAverage: 10.0,
      overview: 'Very scary movie',
      title: 'Jane Doe',
      id: 123);
  const movieList = [movieModel];

  setUpAll(() {
    storageAdapter = MockStorageAdapter();
    favoritesDataSourceImpl = FavoritesDataSourceImpl(storageAdapter);
  });

  group('fetchFavoriteMovies', () {
    test('Should successfully fetch movie list', () async {
      when(storageAdapter.load(FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenAnswer(
              (_) async => jsonDecode(jsonEncode({'favorites': movieList})));

      final res = await favoritesDataSourceImpl.fetchFavoriteMovies();

      verify(storageAdapter.load(FavoritesDataSourceImpl.kMovieListStorageTag))
          .called(1);
      expect(res, movieList);
    });

    test('Should throw exception on movie fetch', () async {
      when(storageAdapter.load(FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenThrow(Exception());

      expect(() => favoritesDataSourceImpl.fetchFavoriteMovies(),
          throwsA(isA<Exception>()));
    });
  });

  group('storeFavoriteMovie', () {
    test('Should successfully store movie list', () async {
      when(storageAdapter.load(FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenAnswer(
              (_) async => jsonDecode(jsonEncode({'favorites': movieList})));
      when(storageAdapter.store(jsonEncode({'favorites': movieList}),
              FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenAnswer((_) async {});

      await favoritesDataSourceImpl.storeFavoriteMovie(movieModel);

      verify(storageAdapter.store(
              jsonEncode({'favorites': List.from(movieList)..add(movieModel)}),
              FavoritesDataSourceImpl.kMovieListStorageTag))
          .called(1);
    });

    test('Should throw exception on movie store', () async {
      when(storageAdapter.load(FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenAnswer(
              (_) async => jsonDecode(jsonEncode({'favorites': movieList})));
      when(storageAdapter.store(
              any, FavoritesDataSourceImpl.kMovieListStorageTag))
          .thenThrow(Exception());

      expect(() => favoritesDataSourceImpl.storeFavoriteMovie(movieModel),
          throwsA(isA<Exception>()));
    });
  });
}
