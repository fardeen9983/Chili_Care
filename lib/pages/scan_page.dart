import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

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
        onPressed: () => capture(context),
        child: Icon(Icons.camera),
      ),
      body: Container(
        color: Color.fromRGBO(0, 109, 179, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await ImagePicker.pickImage(source: ImageSource.camera)
                    .then((file) => this.setState(() {
                          this.image = Image.file(file);
                        }));
              },
              child: Text("Select Image"),
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

  void capture(BuildContext context) async {
    imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    Widget capturedImage = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.file(
            imageFile,
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.60,
          ),
        ),
        RaisedButton(
          onPressed: null,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Done"),
          ),
        )
      ],
    );
  }

  void sendImage() async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri =
        Uri.parse("https://www.floydlabs.com/serve/b2mfjCxSA9vLZCtoWJrwiA");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));
    //contentType: new MediaType('image', 'png'));
    request.fields["UID"] = "user-id";
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }
}
