import 'package:flutter/material.dart';

import '../../crypto_project/utilities/themes.dart';
import '../presentation/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); //named constructor

  static const MyApp _instance =
      MyApp._internal(); //singleton or singleton's instance

  factory MyApp() => _instance;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationThemes(),
      home: const SplashScreen(),
      // initialRoute: RoutesManager.splashRoute,
      // onGenerateRoute: RouteGenerators.getRoute,
    );
  }
}
