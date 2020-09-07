import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelar/providers/user_provider.dart';

class SignupForm extends StatefulWidget {
  final Function showError;

  const SignupForm({Key key, this.showError}) : super(key: key);
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final FocusNode usernameField = FocusNode();
  final FocusNode emailField = FocusNode();
  final FocusNode passwordField = FocusNode();
//  final FocusNode confirmPasswordField = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _username;
  TextEditingController _email;
  TextEditingController _password;
//  TextEditingController _confirmPassword;
  bool passwordVisible= true;

  @override
  void initState() {
    _username = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
//    _confirmPassword = TextEditingController();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    return Container(
      padding: EdgeInsets.all(8.0),
//      decoration: BoxDecoration(
//          border: Border(bottom: BorderSide(color: Colors.grey[100]))
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
                controller: _username,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person,color: Colors.pinkAccent,),
                  labelText: "Full Name", labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,

                ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(emailField);
                }
            ),

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
                  prefixIcon: Icon(Icons.mail,color: Colors.pinkAccent,),
                  labelText: "Email address", labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan)
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                ),
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(passwordField);
                }
            ),

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
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.pink,
                ),
                    onPressed: (){
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    }),),
//              onEditingComplete: () =>
//              FocusScope.of(context).requestFocus(confirmPasswordField),
            ),

//            TextFormField(
//              cursorColor: Colors.cyan,
//              style: TextStyle(
//                color: Colors.white,
//              ),
//              obscureText: true,
//              controller: _confirmPassword,
//              // ignore: missing_return
//              validator: (val) {
//                if (val.isEmpty) return "Confirm password is required";
//              },
//              focusNode: confirmPasswordField,
//              decoration: InputDecoration(labelText: "Confirm password", labelStyle: TextStyle(
//              color: Colors.white,),
//                enabledBorder: UnderlineInputBorder(
//                    borderSide: BorderSide(color: Colors.cyan)
//                ),
//                focusedBorder: UnderlineInputBorder(
//                  borderSide: BorderSide(color: Colors.cyan),
//                ),
//              ),
//            ),


            SizedBox(height: 20.0),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.pinkAccent)
              ),
              textColor: Colors.teal,
              color: Colors.black38,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("Create Account",style: TextStyle(
                  fontSize: 18.0,
                ),),
              ),
              onPressed: () async{
                if (_formKey.currentState.validate()) {
                  if (!await user.signUp(
                      _email.text, _password.text, _username.text))
                    widget.showError();
                }
              },
            ),

          ],
        ),
      ),
    );
  }
}