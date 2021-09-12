// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/favorites/data/datasource/favorites.datasource_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;
import 'dart:io' as _i2;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/core/datasource/storage.adapter.dart' as _i3;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeFile_0 extends _i1.Fake implements _i2.File {}

/// A class which mocks [StorageAdapter].
///
/// See the documentation for Mockito's code generation for more information.
class MockStorageAdapter extends _i1.Mock implements _i3.StorageAdapter {
  MockStorageAdapter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<Map<String, dynamic>> load(String? tag) => (super.noSuchMethod(
          Invocation.method(#load, [tag]),
          returnValue: Future<Map<String, dynamic>>.value(<String, dynamic>{}))
      as _i4.Future<Map<String, dynamic>>);
  @override
  _i4.Future<void> store(String? dataJson, String? tag) =>
      (super.noSuchMethod(Invocation.method(#store, [dataJson, tag]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<void> delete(String? tag) =>
      (super.noSuchMethod(Invocation.method(#delete, [tag]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
  @override
  _i4.Future<_i2.File> openFile(String? tag) =>
      (super.noSuchMethod(Invocation.method(#openFile, [tag]),
              returnValue: Future<_i2.File>.value(_FakeFile_0()))
          as _i4.Future<_i2.File>);
  @override
  String toString() => super.toString();
}
