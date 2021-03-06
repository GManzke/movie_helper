import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final double voteAverage;
  final String? posterPath;
  final List<int> genres;
  final String overview;
  final String title;
  final int id;

  const MovieEntity(
      {this.posterPath,
      required this.voteAverage,
      required this.genres,
      required this.overview,
      required this.title,
      required this.id});

  @override
  List<Object?> get props =>
      [voteAverage, posterPath, genres, overview, title, id];
}
