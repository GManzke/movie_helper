import 'package:equatable/equatable.dart';

class NotFoundException extends Equatable implements Exception {
  @override
  List<Object?> get props => [];
}

class GenericException extends Equatable implements Exception {
  final String error;

  const GenericException(this.error);

  @override
  List<Object?> get props => [error];
}
