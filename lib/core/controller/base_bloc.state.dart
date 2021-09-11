import 'package:equatable/equatable.dart';

class BaseBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

abstract class ErrorBlocOverlayState extends BaseBlocState {
  String get errorTitle;

  String get errorMessage;
}
