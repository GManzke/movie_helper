import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/favorites/domain/usecase/load_favorite_movies.usecase.dart';
import 'package:movie_helper/features/favorites/presentation/controller/favorites.bloc.dart';
import 'package:movie_helper/features/favorites/presentation/controller/favorites.state.dart';

import 'favorites.bloc_test.mocks.dart';

@GenerateMocks([LoadFavoriteMoviesUseCase])
main() {
  late MockLoadFavoriteMoviesUseCase loadFavoriteMoviesUseCase;

  setUp(() {
    loadFavoriteMoviesUseCase = MockLoadFavoriteMoviesUseCase();
  });

  group('FavoritesBloc', () {
    const movieList = [
      MovieEntity(
          posterPath:
              'https://image.tmdb.org/t/p/w500/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg',
          genres: [1],
          voteAverage: 10.0,
          overview: 'Very scary movie',
          title: 'Jane Doe',
          id: 123),
      MovieEntity(
          posterPath:
              'https://image.tmdb.org/t/p/w500/jtAI6OJIWLWiRItNSZoWjrsUtmi.jpg',
          genres: [1],
          voteAverage: 3.0,
          overview: 'Not so scary movie',
          title: 'Halloween (2018)',
          id: 321),
    ];

    blocTest('Should have Loading as initial state',
        build: () =>
            FavoritesBloc(loadFavoriteMoviesUseCase: loadFavoriteMoviesUseCase),
        verify: (FavoritesBloc bloc) =>
            expect(bloc.state, isA<FavoritesLoadingState>()),
        expect: () => []);

    blocTest('Should return a Error state',
        build: () =>
            FavoritesBloc(loadFavoriteMoviesUseCase: loadFavoriteMoviesUseCase),
        act: (FavoritesBloc bloc) {
          when(loadFavoriteMoviesUseCase(const None()))
              .thenAnswer((_) async => const Left(kCacheFailure));
          bloc.add(InitialBlocEvent());
        },
        verify: (_) =>
            verify(loadFavoriteMoviesUseCase(const None())).called(1),
        expect: () =>
            [FavoritesErrorState(movieList: const [], failure: kCacheFailure)]);

    blocTest('Should return state with a movie list',
        build: () =>
            FavoritesBloc(loadFavoriteMoviesUseCase: loadFavoriteMoviesUseCase),
        act: (FavoritesBloc bloc) {
          when(loadFavoriteMoviesUseCase(const None()))
              .thenAnswer((_) async => const Right(movieList));
          bloc.add(InitialBlocEvent());
        },
        expect: () => [FavoritesState(movieList)]);
  });
}
