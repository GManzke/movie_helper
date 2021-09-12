import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movie_helper/core/datasource/api/base.api.abstract.dart';
import 'package:movie_helper/core/datasource/api/base_impl.api.dart';
import 'package:movie_helper/core/datasource/storage.adapter.dart';

import 'bloc.di.dart';
import 'datasource.di.dart';
import 'repository.di.dart';
import 'usecase.di.dart';

final getIt = GetIt.I;

void initializeDi() {
  getIt.registerLazySingleton<BaseApi>(() => BaseApiImpl(http.Client()));
  getIt.registerLazySingleton<StorageAdapter>(() => StorageAdapter());

  initializeDataSource(getIt);
  initializeRepository(getIt);
  initializeUseCase(getIt);
  initializeBloc(getIt);
}
