import 'package:movie_helper/core/api/base.api.abstract.dart';

import '../model/movie.model.dart';

abstract class DiscoveryDataSource {
  Future<List<MovieModel>> getPopularMovies({required int page});
}

class DiscoveryDataSourceImpl implements DiscoveryDataSource {
  final BaseApi _api;

  DiscoveryDataSourceImpl(this._api);

  static const kPopularMoviesPath = '/3/movie/popular';

  @override
  Future<List<MovieModel>> getPopularMovies({required int page}) =>
      _api.get(kPopularMoviesPath, queryParams: {'page': '$page'}).then(
          (value) => List.from(value.body['results'])
              .map((x) => MovieModel.fromJson(x))
              .toList());
}
