import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travelar/models/user.dart';

class UserServices{
  Firestore _firestore = Firestore.instance;

  Future<UserModel> getUserById(String id) => _firestore.collection('users').document(id).get().then((doc){
    return UserModel.fromSnapshot(doc);
  });


}







