import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constant.dart';
import 'package:brew_crew/models/userDataModel.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/models/user.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  List<String> sugars = ['0','1','2','3','4'];

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserSettings>(
      stream: Database(uid: user.uid).userSettings,
      builder: (context, snapshot) {
        if(snapshot.hasData)
        {

          UserSettings userSettings = snapshot.data;

          return Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Update your Brew preferrences',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textFieldDecoration,
                initialValue: userSettings.name,
                validator: (val)=> val.isEmpty? 'Enter the name':null ,
                onChanged: (val){
                  setState(() {
                    _currentName = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              // dropdown
              DropdownButtonFormField(
                decoration: textFieldDecoration.copyWith(contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8)),
                value: _currentSugar ?? userSettings.sugars,
                items: sugars.map((sugar){
                  return DropdownMenuItem(
                  value: sugar,
                  child: Text('$sugar sugars'),
                  );
                }).toList(),
                onChanged: (val){
                  setState(() {
                    _currentSugar = val;
                  });
                },
              ),
              SizedBox(height: 20,),
              Slider(
                min: 100,
                max: 900,
                divisions: 8,
                value: (_currentStrength ?? userSettings.strength).toDouble(),
                activeColor: Colors.brown[(_currentStrength ?? userSettings.strength)],
                inactiveColor: Colors.brown[(_currentStrength ?? userSettings.strength)],
                onChanged: (val){
                  setState(() {
                    _currentStrength=val.round();
                  });
                },
              ),
              SizedBox(height: 20,),
              RaisedButton(
                color: Colors.black,
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await Database(uid: user.uid).updateUserData(
                          _currentName ?? userSettings.name, 
                          _currentSugar ?? userSettings.sugars, 
                          _currentStrength ?? userSettings.strength
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(
                        color: Colors.white
                      ),
                    ),
                  ),
            ],
          ),
        );
        }else{
          return Loading();
        }
        
      }
    );
  }
}