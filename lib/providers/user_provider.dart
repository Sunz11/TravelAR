import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travelar/models/destination.dart';
import 'package:travelar/models/user.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/providers/user_services.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider extends ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn;
  Status _status = Status.Uninitialized;
  Firestore _firestore = Firestore.instance;
  UserServices _userServices = UserServices();
  UserModel _userModel;


  UserModel get userModel => _userModel;
  Status get status => _status;
  FirebaseUser get user => _user;


  UserProvider.instance():
        _auth = FirebaseAuth.instance,
        _googleSignIn = GoogleSignIn()
        {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }



  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      return true;
    } catch (e) {
      print(e.toString());
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }



  Future<bool> signUp(String email, String password, String username)async{
    try{
      _status = Status.Authenticating;
      notifyListeners();

      await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim()).then((users){
        _firestore.collection('users').document(user.uid).setData({
          'username':username,
          'email':email,
          'uid':user.uid,
        });
      });
      return true;
    }catch(e){
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future<bool> signInWithGoogle() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount googleAccount = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential).then((users){
        _firestore.collection('users').document(user.uid).setData({
          'username':user.displayName,
          'email':user.email,
          'photoUrl': user.photoUrl,
          'uid':user.uid,
        });
      });

      return true;

    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }


  Future signOut() async {
    _auth.signOut();
    _googleSignIn.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }


  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      _userModel = await _userServices.getUserById(user.uid);
    }
    notifyListeners();
  }

  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

}

getDestinations(DestinationNotifier destinationNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance.collection('destinations').getDocuments();

  List<Destination> _destinationList = [];

  snapshot.documents.forEach((document) {
    Destination destination = Destination.fromMap(document.data);
    _destinationList.add(destination);
  });

  destinationNotifier.destinationList = _destinationList; //setter destinationList
}




