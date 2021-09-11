import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';
import 'package:movie_helper/features/discovery/domain/usecase/get_popular_movies.usecase.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';

void initializeBloc(GetIt getIt) {
  getIt.registerFactory<DiscoveryBloc>(() =>
      DiscoveryBloc(GetPopularMoviesUseCase(getIt<DiscoveryRepository>())));
}
