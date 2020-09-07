import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelar/data/place_response.dart';
import 'package:travelar/data/result.dart';
import 'package:travelar/models/destination.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/screens/restaurants/search_filter_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelar/data/error.dart';

import 'package:provider/provider.dart';

class PlacesSearch extends StatefulWidget {
  Destination currentDestination;

  PlacesSearch( this.currentDestination);


  @override
  _PlacesSearchState createState() => _PlacesSearchState();
}

class _PlacesSearchState extends State<PlacesSearch> {
//  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController _controller;

  void updateKeyWord(String newKeyword) {
    print(newKeyword);
    setState(() {
      keywords = newKeyword;
    });
  }


  static const String _API_KEY = "";
  List<Marker> markers = <Marker>[];
  Error error;
  List<Result> places;
  String keywords;
  Destination currentDestination;
//  bool searching = true;


  static const String baseUrl =
      "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

  PageController _pageController;
  int prevPage;


  @override
  void initState() {
    searchNearby();

//
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }


  _placesList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 160.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 11.0,
                    ),
                    height: 195.0,
                    width: 285.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          SizedBox(width: 5.0),
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/restaurant_icon.png"),
                                      fit: BoxFit.fitWidth))),
                          SizedBox(width: 15.0),
                          Column(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 10.0,
                                ),
                                Container(
                                  width: 140,
                                  child: Text(
                                    places[index].name,
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),

                                ),
                                SizedBox(
                                  height: 5.0,
                                ),


                                Container(
                                  width: 140,
                                  child: Text(
                                    places[index].vicinity,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),

                                Row(
                                  children: <Widget>[
                                    RatingBarIndicator(
                                      rating: places[index].rating,
                                      itemBuilder: (context,
                                          index) =>
                                          Icon(Icons.star,
                                              color: Colors
                                                  .amber),
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      direction:
                                      Axis.horizontal,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      "(${places[index].rating.toInt()}/5)",
                                      style: TextStyle(
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(
                                      width: 6.0,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.directions),
                                      iconSize: 30.0,
                                      color: Colors.red,
                                      onPressed: () {
                                        _launchMapsUrl(
                                            places[index]
                                                .geometry
                                                .location
                                                .lat,
                                            places[index]
                                                .geometry
                                                .location
                                                .long);
                                      },
                                    ),


                                  ],
                                ),


                              ])
                        ]))))
          ])),
    );

  }

  @override
  Widget build(BuildContext context) {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Nearby Restaurants",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.bold,
          ),),
        actions: <Widget>[
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                  icon: Icon(Icons.filter_list,
                    color: Colors.teal,
                  ),
                  tooltip: 'Filter Search',
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  });
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(destinationNotifier.currentDestination.latitude, destinationNotifier.currentDestination.longitude),
                zoom: 12,
                bearing: 15.0,
                tilt: 75.0, ),

              mapType: MapType.normal,
              onMapCreated: mapCreated,

              markers: Set<Marker>.of(markers),
            ),
          ),
          Positioned(
            bottom: 60.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: markers.length,
                itemBuilder: (BuildContext context, int index) {
                  return _placesList(index);
                },
              ),
            ),
          ),

        ],
      ),
      endDrawer: SearchFilter(updateKeyWord),


      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 120.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            searchNearbyKeyword();
          },
          label: Text('Places Nearby'),
          icon: Icon(Icons.place),
        ),
      ),

    );
    // 1
//

  }

  void searchNearby() async {
    setState(() {
      markers.clear();

    });

    String url =
        '$baseUrl?key=$_API_KEY&location=${widget.currentDestination.latitude},${widget.currentDestination.longitude}&radius=1000&keyword=Restaurant';


    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);

    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  void _handleResponse(data){
    // bad api key or otherwise
    if (data['status'] == "REQUEST_DENIED") {
      setState(() {
        error = Error.fromJson(data);
      });
      // success
    } else if (data['status'] == "OK") {
      setState(() {
        places = PlaceResponse.parseResults(data['results']);
        for (int i = 0; i < places.length; i++) {
          markers.add(
            Marker(
              markerId: MarkerId(places[i].placeId),
              position: LatLng(places[i].geometry.location.lat,
                  places[i].geometry.location.long),
              infoWindow: InfoWindow(
                  title: places[i].name, snippet: places[i].vicinity),
              onTap: () {},
            ),
          );
        }
      });
    } else {
      print(data);
    }
  }

  void searchNearbyKeyword() async {
    setState(() {
      markers.clear();

    });

    String url =
        '$baseUrl?key=$_API_KEY&location=${widget.currentDestination.latitude},${widget.currentDestination.longitude}&radius=1000&keyword=$keywords}';


    print(url);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _handleResponse(data);

    } else {
      throw Exception('An error occurred getting places nearby');
    }
//    setState(() {
//      searching = false;
//    });

  }

  void mapCreated(controller) {

    setState(() {
      _controller = controller;

    });

  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(places[_pageController.page.toInt()].geometry.location.lat,
            places[_pageController.page.toInt()].geometry.location.long),
        zoom: 20.0,
        bearing: 45.0,
        tilt: 45.0),));
  }

  void _launchMapsUrl(double lat, double lng) async {
//    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    final url = "google.navigation:q=$lat,$lng";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}





