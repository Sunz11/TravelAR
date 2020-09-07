import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/user_provider.dart';

class LoginForm extends StatefulWidget {
  final Function showError;
  const LoginForm({Key key, this.showError}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode passwordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _email;
  TextEditingController _password;
  bool passwordVisible = true;

  @override
  void initState() {

    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context );
    void _showPasswordEmailSentDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Forgot your password"),
            content: new Text("An email has been sent to reset your password"),
            actions: <Widget>[
              new FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  LoginForm();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
    return Container(
      padding: EdgeInsets.all(8.0),
//      decoration: BoxDecoration(
//      border: Border(bottom: BorderSide(color: Colors.grey[100]))
//      ),

        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  cursorColor: Colors.cyan,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    // ignore: missing_return
                    if (value.isEmpty) return "Email is required";
                  },
                  controller: _email,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email, color: Colors.pinkAccent,),
                    labelText: "Email address",
                    labelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.cyan)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan),
                    ),),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(passwordField);
                  }
              ),
//
              TextFormField(
                cursorColor: Colors.cyan,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,

                ),
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty) return "Password is required";
                },
                obscureText: passwordVisible,
                controller: _password,
                focusNode: passwordField,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock,color: Colors.pinkAccent,),
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  suffixIcon: IconButton
                    (icon: Icon(
                    passwordVisible
                    ? Icons.remove_red_eye
                    :  Icons.visibility_off,
                    color: Colors.pinkAccent,),
                      onPressed: (){
                        setState(() {
                          passwordVisible = !passwordVisible;
                        });
                      }),
                ),


              ),
              SizedBox(height: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {user.sendPasswordResetEmail(_email.text);
                      _showPasswordEmailSentDialog();
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),),
                  ),

                ],),
              SizedBox(height: 15.0),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.pinkAccent)
                ),
                textColor: Colors.teal,
                color: Colors.black38,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text("Login",style: TextStyle(
                    fontSize: 18.0,
                  ),),
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    if(!await user.signIn(_email.text, _password.text))
                      widget.showError();
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10.0, right: 15.0),
                      child: Divider(
                        color: Colors.pinkAccent,
//                              height: 40,
                      ),),
                  ),
                  Text("OR",style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 15.0, right: 10.0),
                      child: Divider(
                        color: Colors.pinkAccent,
//                                height: 40,
                      ),),
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}