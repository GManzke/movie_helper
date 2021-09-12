// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/favorites/domain/load_favorite_movies.usecase_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/core/failures.dart' as _i5;
import 'package:movie_helper/features/discovery/domain/entities/movie.entity.dart'
    as _i6;
import 'package:movie_helper/features/favorites/domain/repository/favorites.repository.dart'
    as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeEither_0<L, R> extends _i1.Fake implements _i2.Either<L, R> {}

/// A class which mocks [FavoritesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFavoritesRepository extends _i1.Mock
    implements _i3.FavoritesRepository {
  MockFavoritesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>
      loadFavoriteMovies() => (super.noSuchMethod(
              Invocation.method(#loadFavoriteMovies, []),
              returnValue:
                  Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>.value(
                      _FakeEither_0<_i5.Failure, List<_i6.MovieEntity>>()))
          as _i4.Future<_i2.Either<_i5.Failure, List<_i6.MovieEntity>>>);

  @override
  _i4.Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>> storeFavoriteMovie(
          _i6.MovieEntity? movie) =>
      (super.noSuchMethod(Invocation.method(#storeFavoriteMovie, [movie]),
          returnValue: Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>.value(
              _FakeEither_0<_i5.Failure, _i2.None<dynamic>>())) as _i4
          .Future<_i2.Either<_i5.Failure, _i2.None<dynamic>>>);

  @override
  String toString() => super.toString();
}
