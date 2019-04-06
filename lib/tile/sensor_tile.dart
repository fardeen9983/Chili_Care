import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text("Sensor data", textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(fetchState(widget.state), textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Humidity", style: TextStyle(fontSize: 24.0)),
                    Text("${widget.humid}", style: TextStyle(fontSize: 24.0)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Temperature", style: TextStyle(fontSize: 24.0)),
                    Text("${widget.temp}", style: TextStyle(fontSize: 24.0)),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("Light Intensity", style: TextStyle(fontSize: 24.0)),
                    Text("${widget.light}", style: TextStyle(fontSize: 24.0)),
                  ]),
            ),
          ],
        ),
      ),
    );
  }

  String fetchState(int state) {
    String res = "";
    switch (state) {

      case 1:
        res = "Temprature Unfavorable: The range should be 25-35C";
        break;
      case 2:
        res =
        "Humidity Conditions unfavorable. Increase/Decrease water quantity to bring in range 45-70.";
        break;
      case 3:
        res =
        "Light is not sufficient or too much. Bring the values between 800-3000.";
        break;
      case 4:
        res = "All conditions are favorable! Your chili is blooming!";
        break;
      default:
        res =
        "All conditions are unfavorable(Temperature Range: 25-30C, Humidity Range: 45-70%, LightIntensity Range:800-3000.";
        break;
    }
    return res;
  }
}
