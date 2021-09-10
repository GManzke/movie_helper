// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/movie_list/data/repository/movie_list_impl.repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/features/movie_list/data/datasource/movie_list.datasource.dart'
    as _i2;
import 'package:movie_helper/features/movie_list/domain/entities/movie.entity.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [MovieListDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieListDataSource extends _i1.Mock
    implements _i2.MovieListDataSource {
  MockMovieListDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieEntity>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i4.MovieEntity>>.value(<_i4.MovieEntity>[]))
      as _i3.Future<List<_i4.MovieEntity>>);

  @override
  String toString() => super.toString();
}
