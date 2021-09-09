import '../../../../utils.dart';

const kFeaturePath = 'movie_list/data/json';

final popularMoviesSuccessResponse =
    readJsonFile('$kFeaturePath/popular_movies_success.response.json');

final popularMoviesErrorResponse =
    readJsonFile('$kFeaturePath/popular_movies_error.response.json');
