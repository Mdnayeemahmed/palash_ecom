import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebPageFlutter extends StatefulWidget {
  const WebPageFlutter({super.key});

  @override
  State<WebPageFlutter> createState() => _WebPageState();
}

class _WebPageState extends State<WebPageFlutter> {
  late final WebViewController controller;

  _WebPageState() {
    // Initialize controller with NavigationDelegate
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (navigationRequest) async {
          final String host = Uri.parse(navigationRequest.url).host;
          if (host.contains("google.com")) {
            print(navigationRequest.url.toString());
            await launch(navigationRequest.url);
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse("https://palashjewellery.com/"));
  }
  
  @override
  Widget build(BuildContext context) => PopScope(
    canPop: false,
    onPopInvoked: (bool isPop) async {
      if (await controller.canGoBack()) {
        print('object');
        if (mounted) controller.goBack();
        return; // Returning void here
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Exit"),
              content: Text("Do You Want To Close this App?"),
              actions: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red
                  ),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                  },
                  child: Text("OK",style: TextStyle(
                    color: Colors.white
                  ),),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("No"),
                ),

              ],
            );
          },
        );
      }
    },

    child: Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    ),
  );
}
