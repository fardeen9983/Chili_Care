import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photos_library/photos_library.dart';
import 'package:photos_library/asset.dart';
import 'package:photos_library/assetview.dart';
import 'dart:io';


import 'send_image.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Widget image = Text("not selected anything");

  final _assets = List<Asset>();
  bool _firstRun = true;
  PhotosLibraryAuthorizationStatus _status =
      PhotosLibraryAuthorizationStatus.NotDetermined;

  @override
  void initState() {
    super.initState();
    refreshStatus();
  }

  void refreshStatus() async {
    try {
      var status = await PhotosLibrary.authorizeationStatus;
      print("status: $status");
      if (status != PhotosLibraryAuthorizationStatus.Authorized)
        requestAuthorization();
      setState(() {
        this._status = status;
      });
    } catch (e) {}
  }

  void requestAuthorization() async {
    try {
      var status = await PhotosLibrary.requestAuthorization;
      setState(() {
        this._status = status;
      });
    } catch (e) {}
  }

  void loadAssets() async {
    try {
      var assets =
      await PhotosLibrary.fetchMediaWithType(PhotosLibraryMediaType.Photo);
      print(assets);
      setState(() {
        this._assets.clear();
        this._assets.addAll(assets);
      });
    } catch (e) {}
  }

  Widget buildGridView() {
    loadAssets();
    print(_assets);
    print(_status);
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(_assets.length, (index) {
        return AssetView(
            index: index, asset: _assets[index], width: 1000.0, height: 1000.0);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_firstRun) {
      refreshStatus();
      _firstRun = false;
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => capture(context, true),
        child: Icon(Icons.camera),
      ),
      body: Container(
          color: Color.fromRGBO(0, 109, 179, 100),
          child: buildGridView()
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
