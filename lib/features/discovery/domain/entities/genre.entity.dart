import 'package:equatable/equatable.dart';

class GenreEntity extends Equatable {
  final String name;
  final int id;

  const GenreEntity({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];
}
