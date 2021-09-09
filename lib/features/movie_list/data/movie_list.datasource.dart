import 'package:movie_helper/core/base.api.abstract.dart';
import 'package:movie_helper/features/movie_list/domain/entities/movie.entity.dart';

import 'model/movie.model.dart';

abstract class MovieListDataSource {
  Future<List<MovieEntity>> getPopularMovies();
}

class MovieListDataSourceImpl implements MovieListDataSource {
  final BaseApi _api;

  MovieListDataSourceImpl(this._api);

  static const kPopularMoviesPath = '/movie/top_rated';

  @override
  Future<List<MovieModel>> getPopularMovies() => _api
      .get(kPopularMoviesPath)
      .then((value) => List.from(value.body['results'])
          .map((x) => MovieModel.fromJson(x))
          .toList());
}
