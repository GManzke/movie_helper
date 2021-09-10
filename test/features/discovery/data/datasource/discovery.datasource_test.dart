import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/api/base.api.abstract.dart';
import 'package:movie_helper/features/discovery/data/datasource/discovery.datasource.dart';

import '../json/movie_responses.dart';
import 'discovery.datasource_test.mocks.dart';

@GenerateMocks([BaseApi])
main() {
  late MockBaseApi api;
  late DiscoveryDataSourceImpl discoveryDataSourceImpl;

  setUp(() {
    api = MockBaseApi();
    discoveryDataSourceImpl = DiscoveryDataSourceImpl(api);
  });

  group('getMostPopularMovies', () {
    test('Should return a List of Movies from API', () async {
      when(api.get(DiscoveryDataSourceImpl.kPopularMoviesPath)).thenAnswer(
          (_) async => ApiResponse.success(body: popularMoviesSuccessResponse));

      final res = await discoveryDataSourceImpl.getPopularMovies();

      verify(api.get(DiscoveryDataSourceImpl.kPopularMoviesPath)).called(1);
      expect(res.isNotEmpty, isTrue);
    });

    test('Should throw exception', () async {
      when(api.get(DiscoveryDataSourceImpl.kPopularMoviesPath))
          .thenThrow(Exception());

      expect(() => discoveryDataSourceImpl.getPopularMovies(),
          throwsA(isA<Exception>()));
    });
  });
}
