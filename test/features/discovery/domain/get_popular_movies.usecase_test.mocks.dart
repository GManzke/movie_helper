// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/discovery/domain/get_popular_movies.usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: camel_case_types, unnecessary_overrides

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/core/failures.dart' as _i5;
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart'
    as _i6;
import 'package:movie_helper/features/discovery/domain/repository/discovery.repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [DiscoveryRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDiscoveryRepository extends _i1.Mock
    implements _i3.DiscoveryRepository {
  MockDiscoveryRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>
      getPopularMovies() => (super.noSuchMethod(
              Invocation.method(#getPopularMovies, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.MovieEntity>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>);
  @override
  String toString() => super.toString();
}
