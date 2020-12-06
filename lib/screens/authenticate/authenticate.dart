import 'package:flutter/material.dart';
import 'package:vita_instant/screens/authenticate/sign_in.dart';
import 'package:vita_instant/screens/authenticate/register.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  
  //States, variables, bools etc..
  bool showSignIn =true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }//void don't return values
  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else{
      return Register(toggleView: toggleView);
    }
  }
}