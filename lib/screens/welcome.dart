import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/user_provider.dart';
import 'package:travelar/widgets/registration/login.dart';
import 'package:travelar/widgets/registration/signup.dart';


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool signInForm;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    signInForm = true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (!signInForm) {
          setState(() {
            signInForm = true;
          });
          return false;
        } else {
          return true;
        }
      },
      child:Scaffold(
          key: _key,
        body:Stack(
          children: <Widget>[
            Image.asset(
              'assets/welcome.jpg',
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
//              color: Colors.black.withOpacity(0.7),
//              colorBlendMode: BlendMode.dstOver ,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              // Box decoration takes a gradient
              gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [

                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(0.9),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.4),
                  Colors.black.withOpacity(0.1),
                  Colors.black.withOpacity(0.05),
                  Colors.black.withOpacity(0.025),
                ],
              ),
            ),
            ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: <Widget>[

                    const SizedBox(height: kToolbarHeight+70),
                    Center(
                      child:  Image.asset("assets/travelAR_logo.png"),

                    ),



//                Container(
//                  decoration: BoxDecoration(
//                    color: Colors.white,
//                    shape: BoxShape.circle,
//                  ),
//                  width: 80.0,
//                  height: 80.0,
//                ),
//                const SizedBox(height: 30.0),
//                RaisedButton(
//                  textColor: Colors.white,
//                  color: Colors.red,
//                  child: Text("Continue with Google"),
//                  onPressed: (){},
//                ),
                    const SizedBox(height: 20.0),
                    AnimatedSwitcher(
                      child: signInForm ? LoginForm() : SignupForm(),
                      duration: Duration(milliseconds: 200),
                    ),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(23.0),
                          side: BorderSide(color: Colors.pinkAccent)
                      ),
                      textColor: Colors.teal,
                      color: Colors.transparent,
                      child: signInForm
                          ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(top: 13.0, bottom: 13.0),
                        child: Icon(Icons.arrow_back,
                          color: Colors.cyan,
                          size: 29.0,),
                      ),
                      onPressed: () {
                        setState(() {
                          signInForm = !signInForm;
                        });
                      },
                    ),
                    SizedBox(height: 35),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Explore Nepal Locally!', style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                          color: Colors.tealAccent,
                        ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(20.0),
                                side: BorderSide(color: Colors.pinkAccent)
                            ),
                            textColor: Colors.teal,
                            color: Colors.black,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(image: AssetImage("assets/google_logo.png"), height: 25.0),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text("Continue with Google",style: TextStyle(
                                      fontSize: 18.0,
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                            onPressed: () async {
                              if (!await user.signInWithGoogle())
                                showMessage();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        )


      ),
    );
  }
  void showMessage({String message = "Something is wrong"}) {
    _key.currentState.showSnackBar(SnackBar(
      content: Text(message,
      style: TextStyle(color: Colors.white,)),
    ));
  }
}












