import 'package:flutter/material.dart';

class ScannerTile extends StatefulWidget {
  final int humid, light, state, temp, ts;

  const ScannerTile(
      {Key key, this.humid, this.light, this.state, this.temp, this.ts})
      : super(key: key);

  @override
  _ScannerTileState createState() => _ScannerTileState();
}

class _ScannerTileState extends State<ScannerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text("Sensor data"),
            Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Date"),
                ),
                Text("${widget.ts}"),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Humidity"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.humid}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Temperature"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("${widget.temp}"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Light intensity"),
                ),
                Text("${widget.light}"),
              ],
            )
          ],
        ),
      ),
    );
  }

  String fetchState(int state) {
    String res = "";
    switch (state) {
      case 1:
    }
  }
}
