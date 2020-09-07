import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/models/destination.dart';
import 'package:travelar/models/weather.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/screens/restaurants/google_places_api.dart';
import 'package:travelar/widgets/image_carousel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class Details extends StatefulWidget {
  final Destination currentDestination;
  Details(this.currentDestination);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int currentIndex = 0;
  Destination currentDestination;
  OpenWeatherMap weatherData;

  @override
  void initState() {
    fetchEpisodes();
    super.initState();
  }


  Future<void> fetchEpisodes() async {
    try {
      var res = await http.get(
          "https://api.openweathermap.org/data/2.5/weather?lat=${widget.currentDestination.latitude.toString()}&lon=${widget.currentDestination.longitude.toString()}&appid=683fd52c1c4e228b302d03550739b43a");
      var decodeRes = jsonDecode(res.body);
      print(decodeRes);
      weatherData = OpenWeatherMap.fromJson(decodeRes);
      if (mounted) {
        setState(() {

        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override

  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);


    return Scaffold(
      backgroundColor: Colors.black,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _height/2,
              floating: true,
              backgroundColor: Colors.black,
              title: Text(
                destinationNotifier.currentDestination.name,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.pinkAccent,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: destinationNotifier.currentDestination.image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(38.0),
                      bottomRight: Radius.circular(38.0),
                    ),
                    child: FadeInImage(
                      image: NetworkImage(destinationNotifier.currentDestination.image),
                      fit: BoxFit.cover,
                      placeholder: AssetImage('assets/img2.jpg'),
                    ),
                  ),
                ),
              ),
            ),

          ];
        },
        body: Container(
            color: Colors.black, child: generalTab()),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.home,
                color: Colors.teal,
                size: 33,),
//              onPressed: () {
//              }
            ),
            title: Text("Home",
              style: TextStyle(
                color: Colors.teal,
              ),),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.navigation,
                color: Colors.teal,
                size: 33,
              ),
              onPressed: () async {
                String url =
                    "google.navigation:q=${widget.currentDestination.latitude},${widget.currentDestination.longitude}";
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  print('cannot launch');
                }
              },
            ),
            title: Text("Navigation",
            style: TextStyle(
              color: Colors.teal,
              fontSize: 16
            ),),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.restaurant,
                color: Colors.teal,
                size: 33,),
              onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return GooglePlacesApi();
                      }),
                    );

                  },
            ),
            title: Text("Restaurants",
              style: TextStyle(
                color: Colors.teal,
                  fontSize: 16
              ),),
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              icon: Icon(Icons.camera_alt,
                color: Colors.teal,
                size: 33,),
              onPressed: () {
              }
            ),
            title: Text("AR Camera",
              style: TextStyle(
                color: Colors.teal,
                  fontSize: 16
              ),),
          ),
        ],
      ),
//        bottomNavigationBar: BottomNavyBar(
//          selectedIndex: currentIndex,
//          backgroundColor: Colors.black,
////          itemCornerRadius: 15,
////          curve: Curves.ease,
//          animationDuration: Duration(milliseconds: 300),
//          onItemSelected: (index) => setState(() {
//            currentIndex = index;
////            _pageController.animateToPage(index,
////                duration: Duration(milliseconds: 300), curve: Curves.ease);
//          }),
//          items: [
//            BottomNavyBarItem(
//                icon: Icon(Icons.home,
//                  color: Colors.teal,
//                ),
//                title: Text('Home'),
//                activeColor: Colors.grey,
//            ),
//
//            BottomNavyBarItem(
//                icon: IconButton(
//                  icon: Icon(Icons.location_on),
//                  onPressed: () async {
//                    String url =
//                        "google.navigation:q=${widget.currentDestination.latitude},${widget.currentDestination.longitude}";
//                    if (await canLaunch(url)) {
//                      await launch(url);
//                    } else {
//                      print('cannot launch');
//                    }
//                  },
//                color: Colors.teal,
//               ),
//                title: Text('Nav'),
//                activeColor: Colors.grey,
//            ),
//            BottomNavyBarItem(
//                icon: IconButton(
//                  icon: Icon(Icons.restaurant),
//                  color: Colors.teal,
//                  onPressed: (){
//                    Navigator.of(context).push(
//                      MaterialPageRoute(builder: (BuildContext context) {
//                        return GooglePlacesApi();
//                      }),
//                    );
//
//                  },
//                 ),
//                title: Text('Resto'),
//                activeColor: Colors.grey,
//            ),
//            BottomNavyBarItem(
//                icon: Icon(Icons.camera_alt,
//                  color: Colors.teal,
//                 ),
//                title: Text('AR Camera'),
//                activeColor: Colors.grey,
//            ),
//          ],
//        )
    );
  }


  Widget generalTab() {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(8),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Icon(
                Icons.location_on,
                color: Colors.teal,
              ),
              SizedBox(width: 2,),
              Text(
                destinationNotifier.currentDestination.location,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            color: Colors.white10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                          weatherData == null
                              ? 'assets/loading.gif'
                              : 'assets/weather/${weatherData.weather[0].icon}.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                              weatherData == null
                                  ? 'Fetching...'
                                  : '${(weatherData.main.temp - 273.15).toStringAsFixed(2)} °C',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.teal,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                          child: Text(
                              weatherData == null
                                  ? 'Fetching...'
                                  : '${weatherData.weather[0].description}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.teal,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            weatherData == null
                                ? '...'
                                : '${(weatherData.main.tempMin - 273.15).toStringAsFixed(2)} / ${(weatherData.main.tempMax - 273.15).toStringAsFixed(2)} °C',
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(
                              color: Colors.teal,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                            weatherData == null
                                ? '...'
                                : 'Humidity : ${weatherData.main.humidity} %',
                            overflow: TextOverflow.ellipsis,
                            style:TextStyle(
                              color: Colors.teal,
                            ) ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:8.0,top: 10.0),
          child: Text(
            'Photos',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ImageCarousel(),
        ExpansionTile(
          title: Text(
            'Description',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          initiallyExpanded: true,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  destinationNotifier.currentDestination.description,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        ),

      ],
    );

  }
}