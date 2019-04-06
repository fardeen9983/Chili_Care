import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://console.dialogflow.com/api-client/demo/embedded/ab83511e-77ad-458d-a980-0c89120119c7",
      ),
    );
  }
}
