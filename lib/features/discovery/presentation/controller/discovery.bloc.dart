import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/features/discovery/domain/entities/genre.entity.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

import 'discovery.event.dart';
import 'discovery.state.dart';

class DiscoveryBloc extends Bloc<BaseBlocEvent, DiscoveryState> {
  DiscoveryBloc() : super(initialState);

  static DiscoveryState get initialState => DiscoveryLoadingState(const []);

  @override
  Stream<DiscoveryState> mapEventToState(BaseBlocEvent event) async* {
    if (event is InitBlocEvent) {
      await Future.delayed(const Duration(seconds: 2));
      yield DiscoveryState(const [
        MovieEntity(
            posterPath:
                'https://image.tmdb.org/t/p/w500/fYtHxTxlhzD4QWfEbrC1rypysSD.jpg',
            genres: [GenreEntity(name: 'Horror', id: 1)],
            voteAverage: 10.0,
            overview: 'Very scary movie',
            title: 'Jane Doe',
            id: 666),
        MovieEntity(
            posterPath:
                'https://image.tmdb.org/t/p/w500/jtAI6OJIWLWiRItNSZoWjrsUtmi.jpg',
            genres: [GenreEntity(name: 'Horror', id: 1)],
            voteAverage: 3.0,
            overview: 'Not so scary movie',
            title: 'Halloween (2018)',
            id: 666),
        MovieEntity(
            posterPath:
                'https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg',
            genres: [GenreEntity(name: 'Horror', id: 1)],
            voteAverage: 3.0,
            overview: 'Not so scary movie',
            title: 'Tetris',
            id: 666),
        MovieEntity(
            posterPath:
                'https://image.tmdb.org/t/p/w500/2CAL2433ZeIihfX1Hb2139CX0pW.jpg',
            genres: [GenreEntity(name: 'Horror', id: 1)],
            overview: 'Not so scary movie',
            title: 'Leocoout',
            voteAverage: 3.0,
            id: 666)
      ]);
    } else if (event is DismissMovieDiscoveryEvent) {
      yield _handleDismissMovieEvent(event, state);
    } else if (event is FavoriteMovieDiscoveryEvent) {
      yield _handleFavoriteMovieEvent(event, state);
    } else {
      yield initialState;
    }
  }

  DiscoveryState _handleDismissMovieEvent(
      DismissMovieDiscoveryEvent event, DiscoveryState state) {
    return DiscoveryState(List.from(state.movieList)..removeLast());
  }

  DiscoveryState _handleFavoriteMovieEvent(
      FavoriteMovieDiscoveryEvent event, DiscoveryState state) {
    return DiscoveryState(List.from(state.movieList)..removeLast());
  }
}
