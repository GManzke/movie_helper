import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel(
      {String? posterPath,
      required double voteAverage,
      required List<int> genres,
      required String overview,
      required String title,
      required int id})
      : super(
      voteAverage: voteAverage,
            posterPath: posterPath,
            overview: overview,
            genres: genres,
            title: title,
            id: id);

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
      voteAverage: json['vote_average'].toDouble(),
      genres: json['genre_ids'].cast<int>(),
      posterPath: json['poster_path'],
      overview: json['overview'],
      title: json['title'],
      id: json['id']);

  Map<String, dynamic> toJson() => {
        'genre_ids': genres,
        'vote_average': voteAverage,
        'poster_path': posterPath,
        'overview': overview,
        'title': title,
        'id': id
      };
}
