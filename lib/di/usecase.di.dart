import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart';
import 'package:movie_helper/features/favorites/domain/usecase/load_favorite_movies.usecase.dart';
import 'package:movie_helper/features/favorites/domain/usecase/store_favorite_movie.usecase.dart';

void initializeUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetPopularMoviesUseCase>(
      () => GetPopularMoviesUseCase(getIt<DiscoveryRepository>()));
  getIt.registerLazySingleton<StoreFavoriteMovieUseCase>(
      () => StoreFavoriteMovieUseCase(getIt<FavoritesRepository>()));
  getIt.registerLazySingleton<LoadFavoriteMoviesUseCase>(
      () => LoadFavoriteMoviesUseCase(getIt<FavoritesRepository>()));
}
