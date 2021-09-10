import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/api/exceptions.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/movie_list/data/datasource/movie_list.datasource.dart';
import 'package:movie_helper/features/movie_list/data/model/genre.model.dart';
import 'package:movie_helper/features/movie_list/data/model/movie.model.dart';
import 'package:movie_helper/features/movie_list/data/repository/movie_list_impl.repository.dart';

import 'movie_list_impl.repository_test.mocks.dart';

@GenerateMocks([MovieListDataSource])
main() {
  late MockMovieListDataSource dataSource;
  late MovieListRepositoryImpl movieListRepositoryImpl;

  setUp(() {
    dataSource = MockMovieListDataSource();
    movieListRepositoryImpl = MovieListRepositoryImpl(dataSource);
  });

  group('getPopularMovies', () {
    test('Should return Right with List of Movies', () async {
      final movieList = [
        const MovieModel(
            genres: [GenreModel(name: 'Horror', id: 1)],
            voteAverage: 10.0,
            overview: 'Very scary movie',
            title: 'Jane Doe',
            id: 666),
        const MovieModel(
            genres: [GenreModel(name: 'Horror', id: 1)],
            voteAverage: 3.0,
            overview: 'Not so scary movie',
            title: 'Halloween (2018)',
            id: 666)
      ];

      when(dataSource.getPopularMovies()).thenAnswer((_) async => movieList);

      final res = await movieListRepositoryImpl.getPopularMovies();

      verify(dataSource.getPopularMovies()).called(1);
      expect(res, equals(Right(movieList)));
    });

    test('Should return Left with connection Failure', () async {
      when(dataSource.getPopularMovies()).thenThrow(TimeoutException(''));

      final res = await movieListRepositoryImpl.getPopularMovies();

      verify(dataSource.getPopularMovies()).called(1);
      expect(res, equals(const Left(kNoConnectionFailure)));
    });

    test('Should return Left with not found Failure', () async {
      when(dataSource.getPopularMovies()).thenThrow(NotFoundException());

      final res = await movieListRepositoryImpl.getPopularMovies();

      verify(dataSource.getPopularMovies()).called(1);
      expect(res, equals(const Left(kNotFoundFailure)));
    });

    test('Should return Left with generic Failure', () async {
      when(dataSource.getPopularMovies()).thenThrow(Exception());

      final res = await movieListRepositoryImpl.getPopularMovies();

      verify(dataSource.getPopularMovies()).called(1);
      expect(res, equals(const Left(kGenericFailure)));
    });
  });
}
