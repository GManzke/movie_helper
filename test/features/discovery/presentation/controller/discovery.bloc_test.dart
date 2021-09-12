import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.event.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.state.dart';

import 'discovery.bloc_test.mocks.dart';

@GenerateMocks([GetPopularMoviesUseCase])
main() {
  late MockGetPopularMoviesUseCase usecase;

  setUp(() {
    usecase = MockGetPopularMoviesUseCase();
  });

  DiscoveryState getDiscoveryState(Bloc bloc) {
    if (bloc.state is DiscoveryState) {
      return bloc.state;
    } else {
      return DiscoveryState(const []);
    }
  }

  group('DiscoveryBloc', () {
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
        build: () => DiscoveryBloc(usecase),
        verify: (DiscoveryBloc bloc) =>
            expect(bloc.state, isA<DiscoveryLoadingState>()),
        expect: () => []);

    blocTest('Should return a Error state',
        build: () => DiscoveryBloc(usecase),
        act: (DiscoveryBloc bloc) {
          when(usecase(1)).thenAnswer((_) async => const Left(kGenericFailure));
          bloc.add(InitialBlocEvent());
        },
        verify: (_) => verify(usecase(1)).called(1),
        expect: () => [
              DiscoveryErrorState(movieList: const [], failure: kGenericFailure)
            ]);

    blocTest('Should return state with a movie list',
        build: () => DiscoveryBloc(usecase),
        act: (DiscoveryBloc bloc) {
          when(usecase(1)).thenAnswer((_) async => const Right(movieList));
          bloc.add(InitialBlocEvent());
        },
        expect: () => [DiscoveryState(movieList)]);

    blocTest('Should fetch movies when list has 4 movies remaining',
        build: () => DiscoveryBloc(usecase),
        seed: () => DiscoveryState(List.from(movieList)..addAll(movieList)),
        act: (DiscoveryBloc bloc) {
          when(usecase(1)).thenAnswer((_) async => const Right(movieList));
          bloc.add(DismissMovieDiscoveryEvent());
        },
        verify: (DiscoveryBloc bloc) {
          verify(usecase(1)).called(1);
          expect(bloc.state.movieList.length, 6);
        });

    blocTest(
      'Should dismiss movie',
      build: () => DiscoveryBloc(usecase),
      seed: () => DiscoveryState(movieList),
      act: (DiscoveryBloc bloc) => bloc.add(DismissMovieDiscoveryEvent()),
      verify: (DiscoveryBloc bloc) {
        final state = getDiscoveryState(bloc);

        expect(state.movieList.length, 1);
        expect(state.movieList.first.id, 321);
      },
    );

    blocTest(
      'Should favorite movie',
      build: () => DiscoveryBloc(usecase),
      seed: () => DiscoveryState(movieList),
      act: (DiscoveryBloc bloc) =>
          bloc.add(FavoriteMovieDiscoveryEvent(movieList.last)),
      verify: (DiscoveryBloc bloc) {
        final state = getDiscoveryState(bloc);
        expect(state.movieList.first.id, 321);
      },
    );
  });
}
