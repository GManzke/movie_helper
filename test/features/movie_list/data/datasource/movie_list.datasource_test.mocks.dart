// Mocks generated by Mockito 5.0.15 from annotations
// in movie_helper/test/features/movie_list/data/datasource/movie_list.datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: unnecessary_overrides, camel_case_types

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:movie_helper/core/api/base.api.abstract.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeApiResponse_0 extends _i1.Fake implements _i2.ApiResponse {}

/// A class which mocks [BaseApi].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseApi extends _i1.Mock implements _i2.BaseApi {
  MockBaseApi() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<_i2.ApiResponse> get(String? path,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [path], {#headers: headers}),
              returnValue: Future<_i2.ApiResponse>.value(_FakeApiResponse_0()))
          as _i3.Future<_i2.ApiResponse>);
  @override
  _i3.Future<_i2.ApiResponse> post(String? path,
          {Map<String, String>? headers, Map<String, dynamic>? body}) =>
      (super.noSuchMethod(
          Invocation.method(#post, [path], {#headers: headers, #body: body}),
          returnValue:
              Future<_i2.ApiResponse>.value(_FakeApiResponse_0())) as _i3
          .Future<_i2.ApiResponse>);
  @override
  String toString() => super.toString();
}