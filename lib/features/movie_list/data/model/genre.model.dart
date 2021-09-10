import 'package:movie_helper/features/movie_list/domain/entities/genre.entity.dart';

class GenreModel extends GenreEntity {
  const GenreModel({required String name, required int id})
      : super(name: name, id: id);
}
