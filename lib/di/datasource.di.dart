import 'package:get_it/get_it.dart';
import 'package:movie_helper/core/datasource/api/base.api.abstract.dart';
import 'package:movie_helper/core/datasource/storage.adapter.dart';
import 'package:movie_helper/features/discovery/data/datasource/discovery.datasource.dart';
import 'package:movie_helper/features/favorites/data/datasource/favorites.datasource.dart';

void initializeDataSource(GetIt getIt) {
  getIt.registerLazySingleton<DiscoveryDataSource>(
      () => DiscoveryDataSourceImpl(getIt<BaseApi>()));
  getIt.registerLazySingleton<FavoritesDataSource>(
      () => FavoritesDataSourceImpl(getIt<StorageAdapter>()));
}
