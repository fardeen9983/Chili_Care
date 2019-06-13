// Padding(
//                                                 padding: EdgeInsets.all(8.0),
//                                                 child: Image(
//                                                   image: NetworkImage(fileUrl +
//                                                       images[images.keys
//                                                               .toList()[index]]
//                                                           [i]["iname"]),
//                                                 ))


// GridView.builder(
//                                     gridDelegate:
//                                         SliverGridDelegateWithFixedCrossAxisCount(
//                                             crossAxisCount: 3),
//                                     itemCount: images[images.keys.toList()[index]]
//                                         .length,
//                                     itemBuilder: (context, i) =>
//                                         GestureDetector(
//                                             onTap: () => Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) => StatusPage(
//                                                         state: int.parse(images[
//                                                                 images.keys.toList()[index]]
//                                                             [i]["detected"]),
//                                                         text:
//                                                             images[images.keys.toList()[index]]
//                                                                 [i]["fname"],
//                                                         invalid: ""))),
//                                             child: Container()))

// ExpansionTile(
//                             title: Text(images.keys.toList()[index]),
//                             children: <Widget>[
//                               Container(
//                                 height: double.maxFinite,
//                                 child: HistoryImage(
//                                   images: images[index],
//                                   fileURL: fileUrl,
//                                 ),
//                               )
//                             ],
// //                                  ListView.builder(
//                           )