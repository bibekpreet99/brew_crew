import 'package:brew_crew/models/userDataModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database{

  final String uid;
  Database({this.uid});

  final CollectionReference brewCollection = Firestore.instance.collection('user_data');

  Future updateUserData(String name, String sugars, int strength) async{
    return await brewCollection.document(uid).setData({
      'name': name,
      'sugars' : sugars,
      'strength': strength
    });
  }


  // converting snapshots to userdatamodel

  List<UserDataModel> _getUserDataModel(QuerySnapshot snapshot){
    return snapshot.documents.map((user){
      return UserDataModel(
        name: user.data['name'] ?? '',
        sugars: user.data['sugars'] ?? '',
        strength: user.data['strength'] ?? 0
      );
    }).toList();
  }

  // stream for getting documents
  Stream<List<UserDataModel>> get userData{
    return brewCollection.snapshots()
    .map(_getUserDataModel);
  }


  // usersettng model

  UserSettings _userSettingFromDatabase(DocumentSnapshot snapshot){
    return UserSettings(
      name: snapshot.data['name'],
      uid: uid,
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    ) ;
  }

  // stream for getting update from user settings
  Stream<UserSettings> get userSettings{
    return brewCollection.document(uid).snapshots()
    .map(_userSettingFromDatabase);
  }
}