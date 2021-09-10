import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_helper/core/api/base.api.abstract.dart';
import 'package:movie_helper/core/api/exceptions.dart';

const _kTimeOutMs = 10000;

class BaseApiImpl implements BaseApi {
  final http.Client _client;
  final int timeOutMs;

  BaseApiImpl(this._client, {this.timeOutMs = _kTimeOutMs});

  static const kUrl = 'https://api.themoviedb.org/3';

  @override
  Future<ApiResponse> get(String path, {Map<String, String>? headers}) async {
    final res = await _client
        .get(Uri.parse(kUrl + path), headers: headers)
        .timeout(Duration(milliseconds: timeOutMs));

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
