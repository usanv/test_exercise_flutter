import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  Future _link() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('link');
  }

  late Future<ConnectivityResult> connectivityResult;

  @override
  void initState() {
    super.initState();
    connectivityResult = Connectivity().checkConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ConnectivityResult>(
        future: connectivityResult,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.none) {
              return const Center(child: Text("Нет подключения к интернету"));
            } else {
              return FutureBuilder(
                future: _link(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return VScreen(r: snapshot.data);
                  }
                },
              );
            }
          } else {
            return const Center(child: Text("Ошибка при проверке подключения"));
          }
        },
      ),
    );
  }
}

class VScreen extends StatefulWidget {
  String r;
  VScreen({super.key, required this.r});
  @override
  State<VScreen> createState() => _VScreenState();
}

class _VScreenState extends State<VScreen> {
  late InAppWebViewController _webViewController;
  double progress = 0;

  Future<bool> onBackPressed() async {
    _webViewController.goBack();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.r)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                  useShouldOverrideUrlLoading: true,
                  javaScriptCanOpenWindowsAutomatically: true,
                  supportZoom: false),
            ),
            onWebViewCreated: (controller) {
              _webViewController = controller;
            },
            onProgressChanged: (controller, progress) {
              setState(() {
                this.progress = progress / 100;
              });
            },
            onCreateWindow: (controller, createWindowRequest) async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    contentPadding: EdgeInsets.zero,
                    insetPadding: EdgeInsets.zero,
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: InAppWebView(
                        windowId: createWindowRequest.windowId,
                        initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(),
                        ),
                        onWebViewCreated: (controller) {
                          _webViewController = controller;
                        },
                      ),
                    ),
                  );
                },
              );
              return true;
            },
          ),
          progress < 1.0
              ? Center(
                  child: CircularProgressIndicator(
                    value: progress,
                    color: const Color.fromARGB(255, 0, 167, 251),
                    strokeWidth: 3,
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
