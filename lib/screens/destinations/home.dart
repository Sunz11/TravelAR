import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/destination_notifier.dart';
import 'package:travelar/providers/user_provider.dart';
import 'package:travelar/widgets/destination_card.dart';
import 'package:travelar/widgets/drawer.dart';


class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void initState() {
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context, listen: false);
    getDestinations(destinationNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context);
    DestinationNotifier destinationNotifier = Provider.of<DestinationNotifier>(context);


    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('TravelAR',
          style: TextStyle(
            color: Colors.teal[400],
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            fontSize: 30.0,
          ),),
        centerTitle: true,
        actions: <Widget>[

          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => Provider.of<UserProvider>(context, listen: false).signOut(),
          ),
        ],

      ),
      drawer: Drawers(),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 5,),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left:15.0),
                  child: RichText(
                    text: TextSpan(children: [

                      TextSpan(text: 'Namaste, ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white)),
                      TextSpan(text: user.userModel?.username?.split(' ')?.removeAt(0) ?? "username loading..", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.tealAccent)),
                    ], style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height:2,),
              Padding(
                padding: const EdgeInsets.only(right:10.0),
                child: Text('Welcome to Nepal!', style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w500, color: Colors.pinkAccent, ),),
              ),
              SizedBox(height: 20,),
//          Padding(
//            padding: const EdgeInsets.only(
//                top: 8, left: 10, right: 10, bottom: 10),
//            child: Container(
//              decoration: BoxDecoration(
//                color: Colors.white12,
//                borderRadius: BorderRadius.circular(20),
//              ),
//              child: ListTile(
//                leading: Icon(
//                  Icons.search,
//                  color: Colors.pinkAccent,
//                ),
//                title: TextField(
////                  textInputAction: TextInputAction.search,
//                  cursorColor: Colors.cyan,
//                  style: TextStyle(
//                    color: Colors.teal,
//                    fontWeight: FontWeight.w600,
//                  ),
//
////                  onSubmitted: (pattern)async{
////                  },
//                  decoration: InputDecoration(
//                    hintText: "Search for your dream destinations",
//                    hintStyle:  TextStyle(color: Colors.pinkAccent),
//
//                    focusColor: Colors.white,
//                    border: InputBorder.none,
//                  ),
//                ),
//              ),
//            ),
//          ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:20.0,right: 8.0),
                      child: Text('Top Destinations', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.teal[200], ),),
                    ),
                  IconButton(icon: Icon(Icons.more_horiz, color: Colors.pinkAccent,), onPressed: (){},),
                ],
              ),
              SizedBox(height: 10.0),
              Expanded(
                  child: Container(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: destinationNotifier.destinationList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return DestinationCard(
                            destination: destinationNotifier.destinationList[index],
                            name: destinationNotifier.destinationList[index].name,
                            location: destinationNotifier.destinationList[index].location,
                            image: destinationNotifier.destinationList[index].image,
                            latitude: destinationNotifier.destinationList[index].latitude,
                            longitude: destinationNotifier.destinationList[index].longitude,
                            description:  destinationNotifier.destinationList[index].description,


                          );
                        }
                    ),
                  ),
                ),
              SizedBox(height: 40.0),

            ],

          ),

        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        backgroundColor: Colors.red,
//        foregroundColor: Colors.white,
//        onPressed: (){
//          destinationNotifier.currentDestination = null;
//          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
//            return DestinationForm(
//                isUpdating: false,
//            );
//          }),
//          );
//        },
//      ),
    );
  }
}
