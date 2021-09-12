import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';
import 'package:movie_helper/features/favorites/domain/usecase/store_favorite_movie.usecase.dart';

import 'discovery.event.dart';
import 'discovery.state.dart';

class DiscoveryBloc extends Bloc<BaseBlocEvent, DiscoveryState> {
  final StoreFavoriteMovieUseCase storeFavoriteMovieUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  int currentPage = 1;

  DiscoveryBloc(
      {required this.getPopularMoviesUseCase,
      required this.storeFavoriteMovieUseCase})
      : super(initialState);

  static DiscoveryState get initialState => DiscoveryLoadingState(const []);

  static const kMinMovieCount = 4;

  @override
  Stream<DiscoveryState> mapEventToState(BaseBlocEvent event) async* {
    if (event is InitialBlocEvent) {
      yield await _getPopularMovies(state);
    } else if (event is ClearErrorEvent) {
      yield DiscoveryLoadingState(state.movieList);
      yield await _getPopularMovies(state);
    } else if (event is DismissMovieDiscoveryEvent) {
      yield* _handleDismissMovieEvent(event, state);
    } else if (event is FavoriteMovieDiscoveryEvent) {
      yield* _handleFavoriteMovieEvent(event, state);
    } else {
      yield initialState;
    }
  }

  Stream<DiscoveryState> _handleDismissMovieEvent(
      DismissMovieDiscoveryEvent event, DiscoveryState state) async* {
    yield* _handleCardDismiss(event, state);
  }

  Stream<DiscoveryState> _handleFavoriteMovieEvent(
      FavoriteMovieDiscoveryEvent event, DiscoveryState state) async* {
    yield* _handleCardDismiss(event, state);
    await storeFavoriteMovieUseCase(event.movie);
  }

  Stream<DiscoveryState> _handleCardDismiss(
      BaseBlocEvent event, DiscoveryState state) async* {
    yield DiscoveryState(state.movieList.isNotEmpty
        ? (List.from(state.movieList)..removeAt(0))
        : const []);

    if (state.movieList.length == kMinMovieCount) {
      yield await _getPopularMovies(state);
    }
  }

  Future<DiscoveryState> _getPopularMovies(DiscoveryState state) async {
    final res = await getPopularMoviesUseCase(currentPage);
    return res.fold(
      (failure) => DiscoveryErrorState(
        movieList: state.movieList,
        failure: failure,
      ),
      (movieList) {
        currentPage++;
        return DiscoveryState(List.from(state.movieList)..addAll(movieList));
      },
    );
  }
}
