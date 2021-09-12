import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_helper/core/constants.dart';
import 'package:movie_helper/core/controller/base_bloc.event.dart';
import 'package:movie_helper/core/controller/base_bloc.state.dart';
import 'package:movie_helper/core/extension/context.ext.dart';
import 'package:movie_helper/core/ui/error_overlay.ui.dart';
import 'package:movie_helper/di/di.dart';

abstract class BasePage<T extends Bloc<BaseBlocEvent, BaseBlocState>>
    extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  T bloc(BuildContext ctx) => BlocProvider.of(ctx);

  bool get canPop => false;

  String get pageTitle => '';

  List<Widget> actionButton(BuildContext ctx) => [];

  AppBar appBar(BuildContext context) => AppBar(
        title: Text(pageTitle, style: Theme.of(context).textTheme.headline1),
        leading: canPop
            ? IconButton(
                onPressed: context.pop,
                icon: const Icon(Icons.arrow_back_ios_sharp))
            : null,
        actions: actionButton(context),
        automaticallyImplyLeading: false,
        titleSpacing: kDefaultPadding,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        elevation: 0,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: BlocProvider<T>(
        create: (ctx) => getIt.get<T>()..add(InitialBlocEvent()),
        child: BlocListener<T, BaseBlocState>(
          listener: listener,
          child: Stack(
            children: [
              SafeArea(child: layout(context)),
              BlocBuilder<T, BaseBlocState>(
                  builder: (ctx, state) => state is ErrorBlocOverlayState
                      ? ErrorOverlayUi(
                          onDismiss: () => bloc(ctx).add(ClearErrorEvent()),
                          state: state,
                        )
                      : const SizedBox.shrink())
            ],
          ),
        ),
      ),
    );
  }

  void listener(BuildContext context, BaseBlocState state);

  Widget layout(BuildContext context);
}
