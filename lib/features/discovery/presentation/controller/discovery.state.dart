import 'package:movie_helper/core/controller/base_bloc.state.dart';
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
