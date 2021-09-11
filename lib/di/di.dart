import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_helper/core/api/base.api.abstract.dart';
import 'package:movie_helper/core/api/base_impl.api.dart';

import 'bloc.di.dart';
import 'datasource.di.dart';
import 'repository.di.dart';
import 'usecase.di.dart';

final getIt = GetIt.I;

void initializeDi() {
  getIt.registerLazySingleton<BaseApi>(() => BaseApiImpl(http.Client()));

  initializeDataSource(getIt);
  initializeRepository(getIt);
  initializeUseCase(getIt);
  initializeBloc(getIt);
}
