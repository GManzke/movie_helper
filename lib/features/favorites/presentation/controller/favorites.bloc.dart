import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/features/favorites/domain/usecase/load_favorite_movies.usecase.dart';

import 'favorites.state.dart';

class FavoritesBloc extends Bloc<BaseBlocEvent, FavoritesState> {
  final LoadFavoriteMoviesUseCase loadFavoriteMoviesUseCase;

  FavoritesBloc({required this.loadFavoriteMoviesUseCase})
      : super(initialState);

  static FavoritesState get initialState => FavoritesLoadingState(const []);

  @override
  Stream<FavoritesState> mapEventToState(BaseBlocEvent event) async* {
    if (event is InitialBlocEvent) {
      yield await _getPopularMovies(state);
    } else if (event is ClearErrorEvent) {
      yield FavoritesLoadingState(state.movieList);
      yield await _getPopularMovies(state);
    } else {
      yield initialState;
    }
  }

  Future<FavoritesState> _getPopularMovies(FavoritesState state) async {
    final res = await loadFavoriteMoviesUseCase();
    return res.fold(
      (failure) => FavoritesErrorState(
        movieList: state.movieList,
        failure: failure,
      ),
      (movieList) =>
          FavoritesState(List.from(state.movieList)..addAll(movieList)),
    );
  }
}
