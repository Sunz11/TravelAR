import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/home_page.dart';
import 'package:travelar/providers/user_provider.dart';
import 'providers/destination_notifier.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
    create:(context) => UserProvider.instance(),
    ),
    ChangeNotifierProvider(
      create:(context) => DestinationNotifier(),
    ),

  ],
  child: MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ),
),
);




