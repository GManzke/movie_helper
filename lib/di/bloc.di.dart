import 'package:get_it/get_it.dart';
import 'package:movie_helper/features/discovery/presentation/controller/discovery.bloc.dart';

void initializeBloc(GetIt getIt) {
  getIt.registerFactory(() => DiscoveryBloc());
}
