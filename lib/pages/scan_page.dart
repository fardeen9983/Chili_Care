import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'send_image.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    List<String> images = [
      "assets/images/good_light.png",
      "assets/images/bad_light.png",
      "assets/images/adequate_distance.png",
      "assets/images/inappropriate_distance.png",
      "assets/images/proper_focus.png",
      "assets/images/inappropraite_focus.png"
    ],
        text = [

          "Good Light",
          "Bad Light",
          "Adequate Distance",
          "Inadequate Distance",
          "Proper Focus",
          "Inappropriate Focus"
        ];
    op = true;
    widgets = List();
    for (int i = 0; i < images.length; i++) {
      var temp = Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image(
                image: AssetImage(images[i]),
              ),
            ),
            Text(text[i], style: TextStyle(fontSize: 16.0),)
          ],
        ),
      );
      widgets.add(temp);
    }
  }

  bool op;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        // this is ignored if animatedIcon is non null
        // child: Icon(Icons.add),
        visible: op,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => op = true,
        onClose: () => op = true,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.camera_alt),
              backgroundColor: Colors.red,
              label: 'Camera',
              onTap: () => capture(context, false)
          ),
          SpeedDialChild(
            child: Icon(Icons.filter),
            backgroundColor: Colors.blue,
            label: 'Gallery',
            onTap: () => capture(context, true),
          ),

        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child:
                Text("How to take better pictures for image recognition",
                  textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 24.0
                  ),),
              ),
            ),
            Container(
              child: Expanded(
                child: GridView.count(
                  mainAxisSpacing: 0.0,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: widgets,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  File imageFile;

  void capture(BuildContext context, bool method) async {
    if (method)
      imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    else
      imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageFile != null)
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SendImage(file: imageFile)));
  }
}
