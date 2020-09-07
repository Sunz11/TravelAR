import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/models/destination.dart';
import 'package:travelar/screens/destinations/detail.dart';

class DestinationCard extends StatelessWidget {
  final String name;
  final String location;
  final double latitude;
  final String image;
  final double longitude;
  final String description;
  final Destination destination;

  DestinationCard({Key key,@required this.name,@required this.location,this.image, this.destination, this.latitude, this.longitude, this.description}): super(key: key);

  @override
  Widget build(BuildContext context) {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 10.0, 30.0),
      child: InkWell(
        onTap: (){
          destinationNotifier.currentDestination = destination; // setter currentDestination
          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
            return Details(destination);
          }));
          },
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26.0),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    image!= null ?
                   image: 'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
                    height: double.infinity,
                    width: 330.0,
                    fit: BoxFit.cover,
                  ),
//
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: 330.0,
                      decoration: BoxDecoration(
                        // Box decoration takes a gradient
                        gradient: LinearGradient(
                          // Where the linear gradient begins and ends
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          // Add one stop for each color. Stops should increase from 0 to 1
                          colors: [
//                             Colors are easy thanks to Flutter's Colors class.
//                            Colors.black.withOpacity(0.8),
//                            Colors.black.withOpacity(0.7),
//                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.05),
                            Colors.black.withOpacity(0.025),
                          ],
                        ),
                      ),

                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: RichText(text: TextSpan(children: [
                              TextSpan(text: name,
                                  style: TextStyle(fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.tealAccent,)),
                            ]))
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, bottom: 8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.location_on, color: Colors.teal,
                                  size: 18,),
                                SizedBox(width: 5,),
                                Text(location,
                                    style: TextStyle(color: Colors.teal[500]))
                              ],
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
}