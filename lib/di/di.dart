import 'package:get_it/get_it.dart';

import 'bloc.di.dart';
import 'datasource.di.dart';
import 'repository.di.dart';
import 'usecase.di.dart';

final getIt = GetIt.I;

void initializeDi() {
  initializeDataSource(getIt);
  initializeRepository(getIt);
  initializeUseCase(getIt);
  initializeBloc(getIt);
}
