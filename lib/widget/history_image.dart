import 'package:flutter/material.dart';

class HistoryImage extends StatelessWidget {
  final List<dynamic> images;
  final String fileURL;

  const HistoryImage({Key key, @required this.images,@required this.fileURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return  GridView.count(
      crossAxisCount: 2,
      children : mapToImages()
    );
  }

  List<Widget> mapToImages(){
    List<Widget> widgets = new List();
    images.forEach((val){
      widgets.add(GestureDetector(child: Image.network(fileURL + val["iname"]),));
    });
    return widgets;
  }
}
