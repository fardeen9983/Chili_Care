import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:photos_library/photos_library.dart';
import 'package:path/path.dart';
import 'status_page.dart';
class SendImage extends StatefulWidget {
  final File file;

  const SendImage({Key key, @required this.file}) : super(key: key);

  @override
  _SendImageState createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {
  final GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  FirebaseUser user;
  Widget child;
  Widget pre;
  @override
  void initState() {
    super.initState();
    pre = Container(
      color: Color.fromRGBO(0, 109, 179, 100),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(
              widget.file,
//              width: MediaQuery.of(context).size.width * 0.75,
//              height: MediaQuery.of(context).size.height * 0.60,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: sendImage,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 32.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
    child = pre;
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(key: key, body: child),
    );
  }

  void sendImage() async {
    user = await FirebaseAuth.instance.currentUser();

    var stream =
    new http.ByteStream(DelegatingStream.typed(widget.file.openRead()));
    var length = await widget.file.length();

    var uri = Uri.parse(
        "https://www.floydlabs.com/serve/shikhar10000/projects/plantdisease");

    var request = new http.MultipartRequest("POST", uri);
    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(widget.file.path));
    //contentType: new MediaType('image', 'png'));
    request.fields["UID"] = user.uid;
    request.files.add(multipartFile);
    var response = await request.send();
    print(response.statusCode);
    response.stream.transform(utf8.decoder).listen((value) {
      Map<String, dynamic> map = json.decode(value);
      setState(() {
        child =
            StatusPage(text: map["fname"], state: int.parse(map["answer"]),);
      });
    });
  }
}
