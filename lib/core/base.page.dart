import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/di/di.dart';

abstract class BasePage<T extends Bloc<BaseBlocEvent, BaseBlocState>>
    extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<T>(
          create: (ctx) => getIt.get<T>(),
          child: BlocListener<T, BaseBlocState>(
            listener: listener,
            child: layout(context),
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, BaseBlocState state);

  Widget layout(BuildContext context);
}
