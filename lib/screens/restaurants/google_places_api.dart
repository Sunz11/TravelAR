import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/screens/restaurants/places_search.dart';

class GooglePlacesApi extends StatefulWidget {


  @override
  _GooglePlacesApiState createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {




  @override
  Widget build(BuildContext context) {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);

    return Scaffold(
      body: PlacesSearch(destinationNotifier.currentDestination),
    );
  }
}

