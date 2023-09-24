import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_exersice/ui/navigatror/app_navigator.dart';

class MyScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: AppNavigator.initialRoute,
      routes: AppNavigator.routes,
    );
  }
}
