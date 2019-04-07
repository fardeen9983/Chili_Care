import 'package:flutter/material.dart';
import '../localization/app_translations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SensorTile extends StatefulWidget {
  final humid, light, temp;
  final int state;

  const SensorTile({Key key,
    @required this.humid,
    @required this.light,
    @required this.state,
    @required this.temp})
      : super(key: key);

  @override
  _SensorTileState createState() => _SensorTileState();
}

class _SensorTileState extends State<SensorTile> {
  AppTranslations translations;
  SharedPreferences prefs;
  String locale = "en";
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: loaded
          ? Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                translations.text("sensordata"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(fetchState(widget.state),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Table(
                border: TableBorder.all(),
                children: <TableRow>[
                  TableRow(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          translations.text("humidity"),
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${widget.humid}",
                          style: TextStyle(fontSize: 24.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  TableRow(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translations.text("temperature"),
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.temp}",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translations.text("lightitensity"),
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.light}",
                        style: TextStyle(fontSize: 24.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ])
                ],
              ),
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) async {
      this.prefs = prefs;
      locale = prefs.getString("locale");
      if (locale == null) locale = "en";
      translations = await AppTranslations.load(Locale(locale, ""));
      loaded = true;
      setState(() {});
    });
  }

  String fetchState(int state) {
    String res = "";
    switch (state) {
      case 1:
        res = translations.text("sensor1");
        break;
      case 2:
        res =
            translations.text("sensor2");
        break;
      case 3:
        res =
            translations.text("sensor3");
        break;
      case 4:
        translations.text("sensor4");
        break;
      default:
        res =
            translations.text("sensor0");
        break;
    }
    return res;
  }
}
