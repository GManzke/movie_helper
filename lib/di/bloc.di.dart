import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';
import 'package:movie_helper/features/favorites/domain/usecase/store_favorite_movie.usecase.dart';

void initializeBloc(GetIt getIt) {
  getIt.registerFactory<DiscoveryBloc>(() => DiscoveryBloc(
      getPopularMoviesUseCase: getIt<GetPopularMoviesUseCase>(),
      storeFavoriteMovieUseCase: getIt<StoreFavoriteMovieUseCase>()));
}
