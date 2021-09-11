import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';

void initializeUseCase(GetIt getIt) {
  getIt.registerLazySingleton<GetPopularMoviesUseCase>(
      () => GetPopularMoviesUseCase(getIt<DiscoveryRepository>()));
}
