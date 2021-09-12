import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/api/exceptions.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/data/datasource/discovery.datasource.dart';
import 'package:movie_helper/features/discovery/data/model/genre.model.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';
import 'package:movie_helper/features/discovery/data/repository/discovery_impl.repository.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

import 'discovery_impl.repository_test.mocks.dart';

@GenerateMocks([DiscoveryDataSource])
main() {
  late MockDiscoveryDataSource dataSource;
  late DiscoveryRepositoryImpl discoveryRepositoryImpl;

  setUp(() {
    dataSource = MockDiscoveryDataSource();
    discoveryRepositoryImpl = DiscoveryRepositoryImpl(dataSource);
  });

  group('getPopularMovies', () {
    test('Should return Right with List of Movies', () async {
      final movieModelList = [
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
      final List<MovieEntity> movieEntityList = movieModelList;

      when(dataSource.getPopularMovies(page: 1))
          .thenAnswer((_) async => movieModelList);

      final res = await discoveryRepositoryImpl.getPopularMovies(page: 1);

      verify(dataSource.getPopularMovies(page: 1)).called(1);
      expect(res, equals(Right(movieEntityList)));
    });

    test('Should return Left with connection Failure', () async {
      when(dataSource.getPopularMovies(page: 1))
          .thenThrow(TimeoutException(''));

      final res = await discoveryRepositoryImpl.getPopularMovies(page: 1);

      verify(dataSource.getPopularMovies(page: 1)).called(1);
      expect(res, equals(const Left(kNoConnectionFailure)));
    });

    test('Should return Left with not found Failure', () async {
      when(dataSource.getPopularMovies(page: 1)).thenThrow(NotFoundException());

      final res = await discoveryRepositoryImpl.getPopularMovies(page: 1);

      verify(dataSource.getPopularMovies(page: 1)).called(1);
      expect(res, equals(const Left(kNotFoundFailure)));
    });

    test('Should return Left with generic Failure', () async {
      when(dataSource.getPopularMovies(page: 1)).thenThrow(Exception());

      final res = await discoveryRepositoryImpl.getPopularMovies(page: 1);

      verify(dataSource.getPopularMovies(page: 1)).called(1);
      expect(res, equals(const Left(kGenericFailure)));
    });
  });
}
