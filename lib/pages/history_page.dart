import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'status_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  FirebaseUser user;
  SharedPreferences prefs;
  String fileUrl;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.document("user/Constants").snapshots(),
        builder: (context, snap) {
          if (snap.hasData) {
            String fileUrl = snap.data["FileUrl"];
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
                  DocumentSnapshot data = snapshot.data;
                  var history = data.data["history"];
                  //print(history);
                  Map<String, List<dynamic>> images = Map();
                  history.forEach((key, value) {
                    List<dynamic> dat = List();
                    value.forEach((key, value) {
                      dat.add(value);
                    });
                    images[key] = dat;
                  });
                  //print(images);
                  return ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) =>
                        Container(
                          child: ExpansionTile(
                            title: Text(images.keys.toList()[index]),
                            children: <Widget>[
                              Container(
                                height: double.maxFinite,
                                child: GridView.builder(
                                    gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                    itemCount: images[images.keys
                                        .toList()[index]]
                                        .length,
                                    itemBuilder: (context, i) =>
                                        GestureDetector(
                                            onTap: () =>
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StatusPage(
                                                                state: int
                                                                    .parse(
                                                                    images[
                                                                    images.keys
                                                                        .toList()[index]]
                                                                    [i]["detected"]),
                                                                text:
                                                                images[images
                                                                    .keys
                                                                    .toList()[index]]
                                                                [i]["fname"],
                                                                invalid: ""))),
                                            child: Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Image(
                                                  image: NetworkImage(fileUrl +
                                                      images[images.keys
                                                          .toList()[index]]
                                                      [i]["iname"]),
                                                )))),
                              )
                            ],
//                                  ListView.builder(
                          ),
                        ),
                  );
//                return Container();
                }
              },
              stream:
              Firestore.instance.document("user/${user.uid}").snapshots(),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: Text("URL fetch error"),
            );
          }
        });
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) => this.user = user);
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
      fileUrl = prefs.getString("fileUrl");
      if (fileUrl == null) {
        fileUrl = "";
      }
    });
  }

}
