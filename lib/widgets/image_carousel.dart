import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/destination_notifier.dart';


class ImageCarousel extends StatelessWidget {


  Widget build(BuildContext context) {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);
    List<NetworkImage> _listOfImages = <NetworkImage>[];

    return Row(
      children: <Widget>[
        Expanded(
          child: StreamBuilder<DocumentSnapshot>(
              stream: Firestore.instance
                  .collection('destinations')
                  .document(destinationNotifier.currentDestination.id.toString())
                  .snapshots(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        _listOfImages = [];
                        for (int i = 0;
                        i <
                            snapshot.data['photos']
                                .length;
                        i++) {
                          _listOfImages.add(NetworkImage(snapshot
                              .data['photos'][i]));
                        }
                        return Container(
                          height: 200,
                          color: Colors.black,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              child: Carousel(
                                  dotBgColor: Colors.transparent,
                                  boxFit: BoxFit.cover,
                                  images: _listOfImages,
                                  autoplay: false,
                                  indicatorBgPadding: 5.0,
                                  animationCurve: Curves.fastOutSlowIn,
                                  animationDuration:
                                  Duration(milliseconds: 1000)),
                            ),
                          ),
                        );
                      });
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ],
    );
  }
}
