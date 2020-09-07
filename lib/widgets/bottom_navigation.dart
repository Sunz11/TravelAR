//import 'package:flutter/material.dart';
//
//class BottomNavBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BottomNavigationBar(
//      backgroundColor: Colors.black,
//      type: BottomNavigationBarType.fixed,
//
//      items: [
//        BottomNavigationBarItem(
//          icon: Icon(Icons.home,),
//          title: Text("Home"),
//        ),
//        BottomNavigationBarItem(
//          icon: IconButton(
//            icon: Icon(Icons.navigation),
//               onPressed: () async {
//                    String url =
//                        "google.navigation:q=${widget.currentDestination.latitude},${widget.currentDestination.longitude}";
//                    if (await canLaunch(url)) {
//                      await launch(url);
//                    } else {
//                      print('cannot launch');
//                    }
//                  },
//          ),
//          title: Text("Posts"),
//        ),
//        BottomNavigationBarItem(
//          icon: IconButton(
//              icon: Icon(Icons.photo_album),
////              onPressed: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) => AlbumList()),
////                );
////              }
//              ),
//          title: Text("Albums"),
//        ),
//        BottomNavigationBarItem(
//          icon: IconButton(
//            icon: Icon(Icons.photo_album),
////              onPressed: () {
////                Navigator.push(
////                  context,
////                  MaterialPageRoute(builder: (context) => AlbumList()),
////                );
////              }
//          ),
//          title: Text("To Do"),
//        ),
//      ],
//    );
//
//  }
//}
