import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:movie_helper/core/datasource/api/exceptions.dart';
import 'package:movie_helper/core/failures.dart';
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart';
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart';

import '../datasource/discovery.datasource.dart';

class DiscoveryRepositoryImpl implements DiscoveryRepository {
  final DiscoveryDataSource _dataSource;

  DiscoveryRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(
      {required int page}) async {
    try {
      final res = await _dataSource.getPopularMovies(page: page);
      return Right(res);
    } catch (e) {
      if (e is NotFoundException) {
        return const Left(kNotFoundFailure);
      } else if (e is TimeoutException) {
        return const Left(kNoConnectionFailure);
      }
      return const Left(kGenericFailure);
    }
  }
}
