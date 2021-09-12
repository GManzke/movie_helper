import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/datasource/api/base_impl.api.dart';
import 'package:movie_helper/core/datasource/api/exceptions.dart';

import 'base_impl.api_test.mocks.dart';

@GenerateMocks([http.Client])
main() {
  late MockClient mockClient;
  late BaseApiImpl baseApiImpl;

  setUp(() {
    mockClient = MockClient();
    baseApiImpl = BaseApiImpl(mockClient);
  });

  group('get', () {
    const customPath = '/test';
    final uri = Uri.https(BaseApiImpl.kUrl, customPath);

    test('Should return success response when client with valid path is called',
        () async {
      when(mockClient.get(uri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{}', 200));

      final res = await baseApiImpl.get(customPath);

      verify(mockClient.get(uri, headers: anyNamed('headers'))).called(1);
      expect(res.statusCode, 200);
    });

    test('Should throw NotFoundException on 404 error', () async {
      when(mockClient.get(uri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('{}', 404));

      expect(
          () => baseApiImpl.get(customPath), throwsA(isA<NotFoundException>()));
    });

    test('Should throw GenericException on unknown error', () async {
      const customBodyError = '{message: Algo deu errado!}';
      const expectedException = GenericException(customBodyError);

      when(mockClient.get(uri, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(customBodyError, 900));

      expect(() => baseApiImpl.get(customPath), throwsA(expectedException));
    });

    test('Should throw NoConnectionException on timeout', () async {
      baseApiImpl = BaseApiImpl(mockClient, timeOutMs: 0);

      when(mockClient.get(uri, headers: anyNamed('headers'))).thenAnswer(
          (_) async => Future.delayed(const Duration(milliseconds: 1))
              .then((value) => http.Response('{}', 404)));

      expect(
          () => baseApiImpl.get(customPath), throwsA(isA<TimeoutException>()));
    });
  });
}
