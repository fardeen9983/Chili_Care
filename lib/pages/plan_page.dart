import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../tile/sensor_tile.dart';

class PlanPage extends StatefulWidget {
  @override
  _PlanPageState createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        this.user = user;
        loaded = true;
      });
    });
  }

  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return loaded
        ? StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return Container(
              child: SensorTile(
                humid: data["humidity"],
                light: data["light"],
                temp: data["temp"],
                state: data["final"],
              ),
            );
//              return Text("fddsf");
          } else
            return Text("Error");
        },
        stream: Firestore.instance
            .document("user/${user.uid}/stats/SensorData")
            .snapshots())
        : CircularProgressIndicator();
  }
}
