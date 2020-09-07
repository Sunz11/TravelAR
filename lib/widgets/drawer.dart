import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/user_provider.dart';

 class Drawers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(user.userModel?.username ?? "username lading..."),
              accountEmail: Text(user.userModel?.email ?? "email loading...",),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.black87,
                  child: ClipOval(
                    child: (user.userModel.photoUrl!=null)
                        ? Image.network(
                      user.userModel?.photoUrl,
                    ): Text(
                      user.userModel?.username?.substring(0,1),
                      style: TextStyle(
                          color: Colors.pink,
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
//                  backgroundImage: NetworkImage(
//                    user.userModel?.photoUrl,
//              ),
                  ),

              ),
              decoration: BoxDecoration(
                color: Colors.black54,
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color:Colors.teal, size: 24.0,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Destinations'),
                leading: Icon(Icons.navigation, color:Colors.teal, size: 24.0,),
              ),
            ),

            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Food Outlets'),
                leading: Icon(Icons.restaurant, color:Colors.teal, size: 24.0,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color:Colors.teal, size: 24.0,),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color:Colors.teal, size: 24.0,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color:Colors.teal, size: 24.0,),
              ),
            ),

          ],
        ),
    );
  }
}
