import 'package:flutter/material.dart';
import 'package:movie_helper/core/ui/action_button.ui.dart';

class DiscoveryActionButtons extends StatelessWidget {
  final Function() onDismissPressed;
  final Function() onFavoritePressed;

  const DiscoveryActionButtons(
      {Key? key,
      required this.onDismissPressed,
      required this.onFavoritePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ActionButton.dismiss(onDismissPressed: onDismissPressed),
        ActionButton.favorite(onDismissPressed: onDismissPressed),
      ],
    );
  }
}
