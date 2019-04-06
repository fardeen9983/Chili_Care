import 'package:flutter/material.dart';
import 'dart:io';

class HistoryTile extends StatefulWidget {
  final File file;
  final String name;

  const HistoryTile({Key key, this.file, this.name}) : super(key: key);

  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.file(widget.file),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 24.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
