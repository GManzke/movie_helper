import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Function() onPressed;
  final IconData iconData;

  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  const ActionButton.dismiss({Key? key, required this.onPressed})
      : iconData = Icons.close,
        super(key: key);

  const ActionButton.favorite({Key? key, required this.onPressed})
      : iconData = Icons.favorite_border_sharp,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Icon(iconData, color: Colors.red));
  }
}
