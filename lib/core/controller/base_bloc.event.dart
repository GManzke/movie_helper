import 'package:equatable/equatable.dart';

class BaseBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitBlocEvent extends BaseBlocEvent {}
