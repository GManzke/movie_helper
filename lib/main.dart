import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'di/di.dart';

void main() {
  initializeDi();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: kDiscoveryPage,
      routes: appRoutes,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.redAccent, size: 64),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(8),
                  primary: Colors.grey[800],
                  shape: const CircleBorder())),
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            headline2: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          )),
    );
  }
}
