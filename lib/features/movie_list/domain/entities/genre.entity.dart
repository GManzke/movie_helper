import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String name;
  final int id;

  const GenreEntity(this.name, this.id);

  @override
  List<Object?> get props => [name, id];
}
