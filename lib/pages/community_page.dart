import 'package:flutter/material.dart';
import 'webview_page.dart';
class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.pushReplacementNamed(context, "/dashboard"),
      child: Container(
          child: WebViewExample()
      ),
    );
  }
}
