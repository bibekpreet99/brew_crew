import 'package:brew_crew/screens/authenticate/signin.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool isSignin = true;

  void toggleView(){
    setState(()=> isSignin = !isSignin);
  }

  @override
  Widget build(BuildContext context) {
    if(isSignin){
      return Signin(toggleView: toggleView);
    }else{
      return Register(toggleView: toggleView);
    }
  }
}