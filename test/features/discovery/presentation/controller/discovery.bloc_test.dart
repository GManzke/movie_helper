import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_helper/features/discovery/domain/entities/genre.entity.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.event.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.state.dart';

main() {
  late DiscoveryBloc discoveryBloc;

  setUp(() {
    discoveryBloc = DiscoveryBloc();
  });

  tearDown(() => discoveryBloc.close());

  group('DiscoveryBloc', () {
    const movieList = [
      MovieEntity(
          posterPath:
              'https://image.tmdb.org/t/p/w500/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg',
          genres: [GenreEntity(name: 'Horror', id: 1)],
          voteAverage: 10.0,
          overview: 'Very scary movie',
          title: 'Jane Doe',
          id: 123),
      MovieEntity(
          posterPath:
              'https://image.tmdb.org/t/p/w500/jtAI6OJIWLWiRItNSZoWjrsUtmi.jpg',
          genres: [GenreEntity(name: 'Horror', id: 1)],
          voteAverage: 3.0,
          overview: 'Not so scary movie',
          title: 'Halloween (2018)',
          id: 321),
    ];

    blocTest(
      'Should have Loading as initial state',
      build: () => DiscoveryBloc(),
      verify: (DiscoveryBloc bloc) =>
          expect(bloc.state, isA<DiscoveryLoadingState>()),
    );

    blocTest(
      'Should dismiss last movie',
      build: () => DiscoveryBloc(),
      seed: () => DiscoveryState(movieList),
      act: (DiscoveryBloc bloc) => bloc.add(DismissMovieDiscoveryEvent()),
      verify: (DiscoveryBloc bloc) {
        expect(bloc.state.movieList.length, 1);
        expect(bloc.state.movieList.last.id, 123);
      },
    );

    blocTest(
      'Should favorite last movie',
      build: () => DiscoveryBloc(),
      seed: () => DiscoveryState(movieList),
      act: (DiscoveryBloc bloc) =>
          bloc.add(FavoriteMovieDiscoveryEvent(movieList.last)),
      verify: (DiscoveryBloc bloc) {
        expect(bloc.state.movieList.length, 1);
        expect(bloc.state.movieList.last.id, 123);
      },
    );
  });
}
