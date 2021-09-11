import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

class DismissMovieDiscoveryEvent extends BaseBlocEvent {}

class FavoriteMovieDiscoveryEvent extends BaseBlocEvent {
  final MovieEntity movie;

  FavoriteMovieDiscoveryEvent(this.movie);
}
