import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/data/datasource/discovery.datasource.dart';
import 'package:movie_helper/features/discovery/data/repository/discovery_impl.repository.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';

void initializeRepository(GetIt getIt) {
  getIt.registerLazySingleton<DiscoveryRepository>(
      () => DiscoveryRepositoryImpl(getIt<DiscoveryDataSource>()));
}
