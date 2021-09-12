import 'dart:convert';

import 'package:http/http.dart' as http;

import 'base.api.abstract.dart';
import 'exceptions.dart';

const _kTimeOutMs = 10000;

class BaseApiImpl implements BaseApi {
  final http.Client _client;
  final int timeOutMs;

  BaseApiImpl(this._client, {this.timeOutMs = _kTimeOutMs});

  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjN2Y3YTFmMzk2ZGU2MTRjNDA3YzA3Mzg4MDJlN2I4ZiIsInN1YiI6IjYwNDNlNDVlMWE5MzRmMDA0NGZkMGQzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FG_rBQHqbzIlvxje68mIM7OKjhWrHnjJ2yOp1kp4UrY';
  static const kUrl = 'api.themoviedb.org';

  @override
  Future<ApiResponse> get(String path,
      {Map<String, String>? headers, Map<String, String>? queryParams}) async {
    final uri = Uri.https(kUrl, path, queryParams);

    final res = await _client.get(uri, headers: {
      ...headers ?? {},
      'Authorization': 'Bearer $_token'
    }).timeout(Duration(milliseconds: timeOutMs));

    switch (res.statusCode) {
      case 200:
        return ApiResponse(res.statusCode, json.decode(res.body));
      case 404:
        throw NotFoundException();
      default:
        throw GenericException(res.body);
    }
  }

  @override
  Future<ApiResponse> post(String path,
      {Map<String, String>? headers, Map<String, dynamic>? body}) {
    throw UnimplementedError();
  }
}
