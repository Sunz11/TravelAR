import 'dart:collection';

import 'package:travelar/models/destination.dart';
import 'package:flutter/cupertino.dart';

class DestinationNotifier extends ChangeNotifier {
  List<Destination> _destinationList = [];
  Destination _currentDestination;

  UnmodifiableListView<Destination> get destinationList => UnmodifiableListView(_destinationList);

  Destination get currentDestination => _currentDestination;

  set destinationList(List<Destination> destinationList) {
    _destinationList = destinationList;
    notifyListeners();
  }

  set currentDestination(Destination destination) {
    _currentDestination = destination;
    notifyListeners();
  }
  addDestination(Destination destination) {
    _destinationList.insert(0, destination);
    notifyListeners();
  }

  deleteDestination(Destination destination) {
    _destinationList.removeWhere((_destination) => _destination.id == destination.id);
    notifyListeners();
  }

}