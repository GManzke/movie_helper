import 'package:equatable/equatable.dart';

enum HttpMethod { post, get }

class ApiResponse extends Equatable {
  final int statusCode;
  final Map<String, dynamic> body;

  bool get success => statusCode == 200;

  const ApiResponse(this.statusCode, this.body);

  const ApiResponse.success({required this.body}) : statusCode = 200;

  @override
  List<Object?> get props => [statusCode, body];
}

abstract class BaseApi {
  Future<ApiResponse> get(String path, {Map<String, String>? headers}) =>
      _call(path, HttpMethod.get, headers: headers);

  Future<ApiResponse> post(String path,
          {Map<String, String>? headers, Map<String, dynamic>? body}) =>
      _call(path, HttpMethod.post, headers: headers, body: body);

  Future<ApiResponse> _call(String path, HttpMethod method,
      {Map<String, String>? headers, Map<String, dynamic>? body});
}
