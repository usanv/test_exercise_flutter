import 'package:flutter/material.dart';
import 'package:test_exersice/ui/navigatror/app_routes.dart';
import 'package:test_exersice/ui/pages/splash_screen/splash_screen.dart';
import 'package:test_exersice/ui/pages/stub_page/stub_page.dart';
import 'package:test_exersice/ui/pages/webview_page/webview_page.dart';

abstract class AppNavigator {
  static String get initialRoute => AppRoutes.splashScreen;
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splashScreen: (context) => const SplashScreenPage(),
        AppRoutes.stubPage: (context) => const StubPage(),
        AppRoutes.webViewPage: (context) => const WebViewPage(),
      };
}
