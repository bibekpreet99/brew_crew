import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/models/userDataModel.dart';
import 'package:brew_crew/screens/home/userDataTile.dart';

class UserDataList extends StatefulWidget {
  @override
  _UserDataListState createState() => _UserDataListState();
}

class _UserDataListState extends State<UserDataList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<UserDataModel>>(context);
    
    return ListView.builder(
      itemCount: brews.length ?? [],
      itemBuilder: (context, index){
        return UserDataTile(user: brews[index]);
      },
    );
  }
}