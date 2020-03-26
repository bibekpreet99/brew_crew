import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';

class Signin extends StatefulWidget {

  final Function toggleView;

  Signin({this.toggleView});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {

  final AuthService _auth = AuthService();

  // form key
  final _formKey = GlobalKey<FormState>();

  // text field values
  String email = '';
  String password = '';
  String error = '';

  // loading
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[800],
        title: Text('Sign In'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            }, 
            icon: Icon(Icons.person, color: Colors.white,), 
            label: Text(
              'Register',
              style: TextStyle(color: Colors.white),
            )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                validator: (val)=>val.isEmpty ? 'Enter email' : null ,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val){
                  setState(() {
                    email = val; 
                  });
                },  
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textFieldDecoration.copyWith(hintText: 'Password'),
                validator: (val)=>val.isEmpty ? 'Enter password' : null ,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val; 
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.black,
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(()=>loading=true);
                    dynamic result = await _auth.signinWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        error='Email or Password incorrect';
                        loading = false;
                      }); 
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}