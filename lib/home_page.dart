import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/user_provider.dart';
import 'package:travelar/screens/splash.dart';
import 'package:travelar/screens/welcome.dart';
import 'package:travelar/screens/destinations/home.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      // ignore: missing_return
      builder: (context, UserProvider user, _) {
        switch (user.status) {
          case Status.Uninitialized:
            return Splash();
          case Status.Unauthenticated:
          case Status.Authenticating:
            return Welcome();
          case Status.Authenticated:
            return Home();
        }
      },
    );
  }
}