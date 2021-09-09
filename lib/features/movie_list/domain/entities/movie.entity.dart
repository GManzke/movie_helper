import 'package:equatable/equatable.dart';

import 'genre.entity.dart';

class MovieEntity extends Equatable {
  final double voteAverage;
  final String? posterPath;
  final List<GenreEntity> genres;
  final String overview;
  final String title;
  final int id;

  const MovieEntity(this.voteAverage, this.posterPath, this.genres, this.overview,
      this.title, this.id);

  @override
  List<Object?> get props =>
      [voteAverage, posterPath, genres, overview, title, id];
}
