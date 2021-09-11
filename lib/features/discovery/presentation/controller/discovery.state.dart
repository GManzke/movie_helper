import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

class DiscoveryState extends BaseBlocState {
  final List<MovieEntity> movieList;

  DiscoveryState(this.movieList);

  @override
  List<Object?> get props => [movieList];
}

class DiscoveryLoadingState extends DiscoveryState {
  DiscoveryLoadingState(List<MovieEntity> movieList) : super(movieList);
}

class DiscoveryErrorState extends DiscoveryState
    implements ErrorBlocOverlayState {
  final Failure failure;

  DiscoveryErrorState(
      {required List<MovieEntity> movieList, required this.failure})
      : super(movieList);

  @override
  String get errorMessage => failure.message;

  @override
  String get errorTitle => failure.title;

  @override
  List<Object?> get props => [failure, movieList];
}
