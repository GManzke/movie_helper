// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/discovery/data/repository/discovery_impl.repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/features/discovery/data/datasource/discovery.datasource.dart'
    as _i2;
import 'package:movie_helper/features/discovery/data/model/movie.model.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

/// A class which mocks [DiscoveryDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockDiscoveryDataSource extends _i1.Mock
    implements _i2.DiscoveryDataSource {
  MockDiscoveryDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.MovieModel>> getPopularMovies() => (super.noSuchMethod(
          Invocation.method(#getPopularMovies, []),
          returnValue: Future<List<_i4.MovieModel>>.value(<_i4.MovieModel>[]))
      as _i3.Future<List<_i4.MovieModel>>);

  @override
  String toString() => super.toString();
}