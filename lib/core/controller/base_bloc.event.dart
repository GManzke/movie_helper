import 'package:equatable/equatable.dart';

class BaseBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialBlocEvent extends BaseBlocEvent {}

class ClearErrorEvent extends BaseBlocEvent {}
