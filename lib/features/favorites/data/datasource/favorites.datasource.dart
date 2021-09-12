import 'dart:convert';

import 'package:movie_helper/core/datasource/storage.adapter.dart';
import 'package:movie_helper/features/discovery/data/model/movie.model.dart';

abstract class FavoritesDataSource {
  Future<List<MovieModel>> fetchFavoriteMovies();

  Future<void> storeFavoriteMovie(MovieModel movie);
}

class FavoritesDataSourceImpl extends FavoritesDataSource {
  final StorageAdapter _storageAdapter;

  FavoritesDataSourceImpl(this._storageAdapter);

  static const kMovieListStorageTag = 'movie_list_storage_tag';

  @override
  Future<List<MovieModel>> fetchFavoriteMovies() async {
    final movieListJson = await _storageAdapter.load(kMovieListStorageTag);
    return List.from(movieListJson['favorites'])
        .map((x) => MovieModel.fromJson(x))
        .toList();
  }

  @override
  Future<void> storeFavoriteMovie(MovieModel movie) async {
    final movieListJson = await _storageAdapter.load(kMovieListStorageTag);
    final List<MovieModel> movieModelList =
        List.from(movieListJson['favorites'])
            .map((x) => MovieModel.fromJson(x))
            .toList()
          ..add(movie);

    _storageAdapter.store(
        jsonEncode({'favorites': movieModelList}), kMovieListStorageTag);
  }
}
