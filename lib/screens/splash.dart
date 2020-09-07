import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SpinKitFadingCircle(
        color: Colors.pinkAccent,
        size: 50,

      )
    );
  }
}