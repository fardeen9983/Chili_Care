import 'package:flutter/material.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              "No data avialable",
              style: TextStyle(fontSize: 24.0),
            ),
          );
        } else {
          return Container(
            child: Text("showing data"),
          );
        }
      },
      stream: null,
    );
  }
}
