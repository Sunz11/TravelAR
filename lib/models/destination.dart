import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  String id;
  String name;
  String location;
  double latitude;
  double longitude;
  String description;
  String image;

//  Destination( this.id,this.name, this.location, this.latitude, this.longitude, this.description, this.image);
Destination();

  Destination.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    location = data['location'];
    image = data['image'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    description = data['description'];

  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'location': location,
      'image': image,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,

    };
  }

}