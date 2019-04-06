import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/images/home.png",
          width: 100.0,
          height: 100.0,
        ),
      ),
    );
  }
}
