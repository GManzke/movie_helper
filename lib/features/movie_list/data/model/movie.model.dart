import 'package:movie_helper/features/movie_list/data/model/genre.model.dart';
import 'package:movie_helper/features/movie_list/domain/entities/genre.entity.dart';
import 'package:movie_helper/features/movie_list/domain/entities/movie.entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel(
      {String? posterPath,
      required List<GenreEntity> genres,
      required double voteAverage,
      required String overview,
      required String title,
      required int id})
      : super(voteAverage, posterPath, genres, overview, title, id);

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
      genres: List.from(json['genre_ids'])
          .map((id) => GenreModel(id: id, name: 'genre'))
          .toList(),
      voteAverage: json['vote_average'],
      posterPath: json['poster_path'],
      overview: json['overview'],
      title: json['title'],
      id: json['id']);
}
