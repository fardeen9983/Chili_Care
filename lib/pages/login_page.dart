import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences prefs;
  FirebaseAuth auth;
  TextEditingController pass, mail;

  @override
  void initState() {
    super.initState();
    pass = TextEditingController();
    mail = TextEditingController();
    auth = FirebaseAuth.instance;
    SharedPreferences.getInstance().then((prefs) => this.prefs = prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(207, 232, 222, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: ListView(
            padding: EdgeInsets.all(0.0),
            children: <Widget>[
              Image.asset("assets/images/logo.png"),
              Text(
                "Chilli Care",
                style: TextStyle(
                  fontSize: 48.0,
                  color: Colors.red,
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
                              labelText: "Email id",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                              labelText: "Password",
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
                                "Sign Up",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                "Forgot Password",
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
                    signIn();
                  else {
                    signIn();
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
                        "Log In",
                        style: TextStyle(fontSize: 24.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn() {
    Navigator.pushReplacementNamed(context, "/dashboard");
  }
}
