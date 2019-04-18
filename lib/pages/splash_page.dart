import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'login_page.dart';
import 'dashboard.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SharedPreferences prefs;
  bool loggedin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SplashScreen(
          seconds: 3,
          photoSize: 200,
          title: Text(
            "ChilliCare",
            style: TextStyle(
              shadows: <Shadow>[
                Shadow(offset: Offset(-3.0, -2.0)),
              ],
              fontSize: 48.0,
              fontFamily: "CopperPlateGothic",
              color: Colors.white,
            ),
          ),
          image: Image(image: AssetImage("assets/images/logo.png")),
          navigateAfterSeconds: loggedin ? DashBoard() : LoginPage(),
          loaderColor: Colors.black,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      if (prefs.getBool("loggedin") != null) {
        loggedin = prefs.getBool("loggedin");
      } else {
        loggedin = false;
      }
      setState(() {});
    });
  }
}
