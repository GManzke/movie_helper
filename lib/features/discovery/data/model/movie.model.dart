import 'package:movie_helper/features/discovery/data/model/genre.model.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel(
      {String? posterPath,
      required List<GenreModel> genres,
      required double voteAverage,
      required String overview,
      required String title,
      required int id})
      : super(
            voteAverage: voteAverage,
            posterPath: posterPath,
            genres: genres,
            overview: overview,
            title: title,
            id: id);

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
      genres: List.from(json['genre_ids'])
          .map((id) => GenreModel(id: id, name: 'genre'))
          .toList(),
      voteAverage: json['vote_average'].toDouble(),
      posterPath: json['poster_path'],
      overview: json['overview'],
      title: json['title'],
      id: json['id']);
}
