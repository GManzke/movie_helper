import 'package:movie_helper/core/api/base.api.abstract.dart';

import '../model/movie.model.dart';

abstract class DiscoveryDataSource {
  Future<List<MovieModel>> getPopularMovies();
}

class DiscoveryDataSourceImpl implements DiscoveryDataSource {
  final BaseApi _api;

  DiscoveryDataSourceImpl(this._api);

  static const kPopularMoviesPath = '/movie/popular';

  @override
  Future<List<MovieModel>> getPopularMovies() => _api
      .get(kPopularMoviesPath)
      .then((value) => List.from(value.body['results'])
          .map((x) => MovieModel.fromJson(x))
          .toList());
}
