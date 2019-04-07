import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../localization/app_translations.dart';

class StatusPage extends StatefulWidget {
  final int state;
  final String text;
  final String invalid;

  const StatusPage(
      {Key key, @required this.state, @required this.text, @required this.invalid})
      : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  String url;
  DocumentReference constant;
  AppTranslations translations;
  SharedPreferences prefs;
  String locale = "en";
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          url = data["FileUrl"] + widget.text;
          return Scaffold(
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.state != 0 ? Image(
                      image: NetworkImage(url),
                    ) : Text(""),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: fetchStatus(widget.state),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
      stream: Firestore.instance.document("user/Constants").snapshots(),
    );
  }

  @override
  void initState() {
    super.initState();
    constant = Firestore.instance.document("user/Constants");
    SharedPreferences.getInstance().then((prefs) async {
      this.prefs = prefs;
      locale = prefs.getString("locale");
      if (locale == null) locale = "en";
      translations = await AppTranslations.load(Locale(locale, ""));
      loaded = true;
      setState(() {});
    });
  }

  Text fetchStatus(int state) {
    String res = "";
    switch (state) {
      case 1:
        res =
            translations.text("state1");
        break;
      case 2:
        res =
            translations.text("state2");
        break;
      case 3:
        res =
            translations.text("state3");
        break;
      case 4:
        res =
            translations.text("state4");
        break;
      case 5:
        res =
            translations.text("state5");
        break;
      case 0:
        res =
        "Plant is Healthy \nWonderfull NO disease has been detected. Continue to provide adequate water and humidity</li> <li>use sensors to check if plant is getting adequate water and temprature.</li></ul>";
        break;
      case 6:
        res = "Invalid image\n Object detected : ${widget.invalid}";
    }
    return Text(
      "State : " + res,
      style: TextStyle(fontSize: 24.0),
      textAlign: TextAlign.center,
    );
  }
}
