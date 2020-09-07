import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const ID = "id";
  static const USERNAME = "username";
  static const EMAIL = "email";
  static const IMAGE = "photoUrl";

  String _id;
  String _username;
  String _email;
  String _photoUrl;


  String get username => _username;
  String get email => _email;
  String get id => _id;
  String get photoUrl => _photoUrl;


  UserModel.fromSnapshot(DocumentSnapshot snapshot){
    Map data = snapshot.data;
    _username = data[USERNAME];
    _email = data[EMAIL];
    _id = data[ID];
    _photoUrl = data[IMAGE];
  }
}




