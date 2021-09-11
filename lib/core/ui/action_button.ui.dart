import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function() onDismissPressed;
  final IconData iconData;

  const ActionButton({
    Key? key,
    required this.onDismissPressed,
    required this.iconData,
  }) : super(key: key);

  const ActionButton.dismiss({Key? key, required this.onDismissPressed})
      : iconData = Icons.close,
        super(key: key);

  const ActionButton.favorite({Key? key, required this.onDismissPressed})
      : iconData = Icons.favorite_border_sharp,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onDismissPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Icon(iconData, color: Colors.redAccent));
  }
}
