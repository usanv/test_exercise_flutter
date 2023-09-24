import 'dart:math';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_exersice/domain/firebase/firebase_config.dart';
import 'package:test_exersice/ui/pages/error_page/error_page.dart';
import 'package:test_exersice/ui/pages/stub_page/stub_page.dart';
import 'package:test_exersice/ui/pages/webview_page/webview_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future<Widget> _screen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // удаление данных из бд
    // await prefs.remove('link');
    final String? link = prefs.getString('link');
    if (link != null) {
      return const WebViewPage();
    } else {
      final RemoteConfigService remoteConfigService = RemoteConfigService();
      debugPrint('${remoteConfigService.getLink()}, remote');
      if (remoteConfigService.getLink() != '') {
        await prefs.setString('link', remoteConfigService.getLink());
        return const WebViewPage();
      } else {
        return const StubPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FlutterSplashScreen.fadeIn(
        backgroundColor: Color.fromRGBO(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), 0.1),
        childWidget: Center(
          child: Lottie.asset('assets/animation/welcome.json'),
        ),
        defaultNextScreen: FutureBuilder<Widget>(
          future: _screen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              return snapshot.data ?? const ErrorPage();
            }
          },
        ),
      ),
    );
  }
}
