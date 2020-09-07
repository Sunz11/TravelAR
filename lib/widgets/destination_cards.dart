//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:travelar/auth/destination_notifier.dart';
//import 'package:travelar/auth/user_provider.dart';
//import 'destination_card.dart';
////import 'package:travelar/widgets/destination_card.dart';
//
//class DestinationCards extends StatefulWidget {
//  @override
//  _DestinationCardsState createState() => _DestinationCardsState();
//}
//
//class _DestinationCardsState extends State<DestinationCards> {
//
//
//  @override
//  void initState() {
//    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);
//    getDestinations(destinationNotifier);
//    super.initState();
//  }
//
//  @override
//
//  Widget build(BuildContext context) {
//    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);
//    return Container(
//        child: ListView.builder(
//            scrollDirection: Axis.horizontal,
//            itemCount: destinationNotifier.destinationList.length,
//            shrinkWrap: true,
//            itemBuilder: (context, index) {
//              return DestinationCard(
//                destination: destinationNotifier.destinationList[index],
//                name: destinationNotifier.destinationList[index].name,
//                location: destinationNotifier.destinationList[index].location,
//
//              );
//            }));
//  }
//}