import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';

import 'discovery.event.dart';
import 'discovery.state.dart';

class DiscoveryBloc extends Bloc<BaseBlocEvent, DiscoveryState> {
  final GetPopularMoviesUseCase _getPopularMoviesUseCase;

  DiscoveryBloc(this._getPopularMoviesUseCase) : super(initialState);

  static DiscoveryState get initialState => DiscoveryLoadingState(const []);

  @override
  Stream<DiscoveryState> mapEventToState(BaseBlocEvent event) async* {
    if (event is InitBlocEvent) {
      final res = await _getPopularMoviesUseCase();
      yield res.fold(
        (failure) => DiscoveryErrorState(
          movieList: state.movieList,
          failure: failure,
        ),
        (movieList) => DiscoveryState(movieList),
      );
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
    return _removeLastMovieFromList(state.movieList);
  }

  DiscoveryState _handleFavoriteMovieEvent(
      FavoriteMovieDiscoveryEvent event, DiscoveryState state) {
    return _removeLastMovieFromList(state.movieList);
  }

  DiscoveryState _removeLastMovieFromList(List<MovieEntity> movieList) {
    if (movieList.isNotEmpty) {
      return DiscoveryState(List.from(state.movieList)..removeLast());
    } else {
      return DiscoveryState(const []);
    }
  }
}
