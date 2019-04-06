import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'send_image.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Widget image = Text("not selected anything");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => capture(context, false),
        child: Icon(Icons.camera),
      ),
      body: Container(
        color: Color.fromRGBO(0, 109, 179, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () => capture(context, true),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text(
                  "Select Image",
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: image,
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
