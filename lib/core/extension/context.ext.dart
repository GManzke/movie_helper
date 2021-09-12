import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  void pop() => Navigator.of(this).pop();

  void pushNamed(String route) => Navigator.of(this).pushNamed(route);
}
