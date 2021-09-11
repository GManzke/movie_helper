import '../../../../utils.dart';

const kFeaturePath = 'discovery/data/json';

final popularMoviesSuccessResponse =
    readJsonFile('$kFeaturePath/popular_movies_success.response.json');

final popularMoviesErrorResponse =
    readJsonFile('$kFeaturePath/popular_movies_error.response.json');
