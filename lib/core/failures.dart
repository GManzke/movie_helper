import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String title;
  final String message;

  const Failure({this.title = 'Algo deu errado', required this.message});

  @override
  List<Object?> get props => [title, message];
}

const kNoConnectionFailure = NoConnectionFailure();
const kNotFoundFailure = NotFoundFailure();
const kGenericFailure = GenericFailure();

class NotFoundFailure extends Failure {
  const NotFoundFailure()
      : super(message: 'Não foi possível carregar os filmes');
}

class NoConnectionFailure extends Failure {
  const NoConnectionFailure() : super(message: 'Verifique a sua conexão');
}

class GenericFailure extends Failure {
  const GenericFailure()
      : super(message: 'Não foi possível concluir a solicitação');
}
