import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

class FavoritesState extends BaseBlocState {
  final List<MovieEntity> movieList;

  FavoritesState(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class FavoritesLoadingState extends FavoritesState {
  FavoritesLoadingState(List<MovieEntity> movieList) : super(movieList);
}

class FavoritesErrorState extends FavoritesState
    implements ErrorBlocOverlayState {
  final Failure failure;

  FavoritesErrorState(
      {required List<MovieEntity> movieList, required this.failure})
      : super(movieList);

  @override
  String get errorMessage => failure.message;

  @override
  String get errorTitle => failure.title;

  @override
  List<Object?> get props => [failure, movieList];
}
