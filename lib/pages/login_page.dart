import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../localization/app_translations.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AppTranslations translations;
  SharedPreferences prefs;
  String locale = "en";
  bool loaded = false;
  FirebaseAuth auth;
  TextEditingController pass, mail;
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    pass = TextEditingController();
    mail = TextEditingController();
    auth = FirebaseAuth.instance;
    SharedPreferences.getInstance().then((prefs) async {
      this.prefs = prefs;
      locale = prefs.getString("locale");
      if (locale == null) locale = "en";
      translations = await AppTranslations.load(Locale(locale, ""));
      loaded = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Container(
        color: Color.fromRGBO(207, 232, 222, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: loaded ? ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              Image.asset("assets/images/logo.png"),
              Text(
                translations.text("chillicare"),
                style: TextStyle(
                  shadows: <Shadow>[
                    Shadow(offset: Offset(-3.0, -2.0)),
                  ],
                  fontSize: 48.0,
                  fontFamily: "CopperPlateGothic",
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Card(
                elevation: 10.0,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: mail,
                          decoration: InputDecoration(
                              labelText: translations.text("emailid"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                              labelText: translations.text("password"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child: Text(
                                translations.text("signup"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                translations.text("forgotpassword"),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  if (mail.text.isNotEmpty && pass.text.isNotEmpty)
                    signIn(mail.text, pass.text);
                  else {
                    key.currentState.showSnackBar(
                        SnackBar(content: Text("Please Enter all the fields")));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 8.0),
                      child: Text(
                        translations.text("login"),
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ) : Center(child: CircularProgressIndicator(),),
        ),
      ),
    );
  }

  void signIn(String mail, String pass) {
    auth.signInWithEmailAndPassword(email: mail, password: pass).then((user) {
      if (user.uid.isNotEmpty) {
        prefs.setBool("loggedin", true);
        Navigator.pushReplacementNamed(context, "/dashboard");
      } else
        key.currentState.showSnackBar(
            SnackBar(content: Text("Invalid Credentials. Try again!!!")));
    });
  }
}
