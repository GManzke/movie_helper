import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_helper/core/api/base.api.abstract.dart';
import 'package:movie_helper/core/api/exceptions.dart';

const _kTimeOutMs = 10000;

class BaseApiImpl implements BaseApi {
  final http.Client _client;
  final int timeOutMs;

  BaseApiImpl(this._client, {this.timeOutMs = _kTimeOutMs});

  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjN2Y3YTFmMzk2ZGU2MTRjNDA3YzA3Mzg4MDJlN2I4ZiIsInN1YiI6IjYwNDNlNDVlMWE5MzRmMDA0NGZkMGQzYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.FG_rBQHqbzIlvxje68mIM7OKjhWrHnjJ2yOp1kp4UrY';
  static const kUrl = 'https://api.themoviedb.org/3';

  @override
  Future<ApiResponse> get(String path, {Map<String, String>? headers}) async {
    final res = await _client.get(Uri.parse(kUrl + path), headers: {
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
