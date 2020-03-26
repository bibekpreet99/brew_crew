import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/shared/loading.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();

  // form key
  final _formkey = GlobalKey<FormState>();

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
        title: Text('Register'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton.icon(
            onPressed: (){
              widget.toggleView();
            }, 
            icon: Icon(Icons.person, color: Colors.white,), 
            label: Text(
              'Sign In',
              style: TextStyle(color: Colors.white),
            )
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: textFieldDecoration.copyWith(hintText: 'Email'),
                validator: (val)=> val.isEmpty ? 'Enter the email' : null ,
                onChanged: (val){
                  setState(() {
                    email = val; 
                  });
                },  
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textFieldDecoration.copyWith(hintText: 'Password'),
                validator: (val)=> val.length<6 ? 'Passsword must be atleast 6 characters long' : null ,
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
                  if(_formkey.currentState.validate()){
                    setState(()=>loading=true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Email is not valid';
                        loading = false;
                      });
                    }
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                error,
                style: TextStyle(
                  color: Colors.red,                  
                  fontSize: 14
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}