import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_helper/core/base.api.abstract.dart';
import 'package:movie_helper/features/movie_list/data/movie_list.datasource.dart';

import 'json/movie_responses.dart';
import 'movie_list.datasource_test.mocks.dart';

@GenerateMocks([BaseApi])
main() {
  late MockBaseApi api;
  late MovieListDataSourceImpl movieListDataSourceImpl;

  setUp(() {
    api = MockBaseApi();
    movieListDataSourceImpl = MovieListDataSourceImpl(api);
  });

  group('getMostPopularMovies', () {
    test('Should return a List of Movies from API', () async {
      when(api.get(MovieListDataSourceImpl.kPopularMoviesPath)).thenAnswer(
          (_) async => ApiResponse.success(body: popularMoviesSuccessResponse));

      final res = await movieListDataSourceImpl.getPopularMovies();

      verify(api.get(MovieListDataSourceImpl.kPopularMoviesPath)).called(1);
      expect(res.isNotEmpty, isTrue);
    });

    test('Should return a List of Movies from API', () async {
      when(api.get(MovieListDataSourceImpl.kPopularMoviesPath))
          .thenThrow(Exception());

      expect(() => movieListDataSourceImpl.getPopularMovies(),
          throwsA(isA<Exception>()));
    });
  });
}
