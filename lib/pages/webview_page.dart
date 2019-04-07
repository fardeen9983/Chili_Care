import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewExample> {
  TextEditingController controller = TextEditingController();
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  var urlString = "https://bot.dialogflow.com/d16180b5-88af-4a56-902c-90631f51a9f0";

  launchUrl() {
    setState(() {
      urlString = controller.text;
      flutterWebviewPlugin.reloadUrl(urlString);
    });
  }

  @override
  void initState() {
    super.initState();

//    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged wvs) {
//      print(wvs.type);
//    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: urlString,
      withZoom: false,
    );
  }
}
