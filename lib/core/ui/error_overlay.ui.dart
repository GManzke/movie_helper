import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_helper/core/controller/base_bloc.state.dart';

class ErrorOverlayUi extends StatelessWidget {
  final ErrorBlocOverlayState state;
  final Function() onDismiss;

  const ErrorOverlayUi({Key? key, required this.state, required this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyleHeadline3 = Theme.of(context).textTheme.headline3;

    return WillPopScope(
      onWillPop: () async {
        onDismiss();
        return true;
      },
      child: AlertDialog(
        title: Text(state.errorTitle,
            style: Theme.of(context).textTheme.headline2),
        content: Text(state.errorMessage, style: textStyleHeadline3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        actions: [
          TextButton(
              onPressed: onDismiss,
              child: Text('Tentar novamente', style: textStyleHeadline3))
        ],
      ),
    );
  }
}
