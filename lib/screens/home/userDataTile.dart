import 'package:flutter/material.dart';
import 'package:brew_crew/models/userDataModel.dart';

class UserDataTile extends StatelessWidget {

  final UserDataModel user;

  UserDataTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Card(
        margin: EdgeInsets.only(top: 10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/coffee_icon.png'),
            backgroundColor: Colors.brown[user.strength],
            radius: 30,
          ),
          title: Text(user.name),
          subtitle: Text('takes ${user.sugars} sugar(s)'),
        ),
      ),

    );
  }
}