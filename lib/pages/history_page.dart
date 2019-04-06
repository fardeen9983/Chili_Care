import 'package:flutter/material.dart';
import '../tile/history_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (!snapshot.hasData) {

          return Container(
            alignment: Alignment.center,
            child: Text(
              "No data avialable",
              style: TextStyle(fontSize: 12.0),
            ),
          );
        } else {
          return ListView.builder(itemBuilder: null);
        }
      },
      stream: Firestore.instance.document("user/${user.uid}").snapshots(),
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) => this.user = user);
  }
}
