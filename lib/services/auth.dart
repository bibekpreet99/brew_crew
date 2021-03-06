import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _getUserFromFireBaseUser(FirebaseUser user){
    return user !=null ? User(uid: user.uid) : null;
  }

  // setting up user steam to detect changes in auth
  Stream<User> get user{
    return _auth.onAuthStateChanged
    .map(_getUserFromFireBaseUser);
  }

  // signin annon
  Future signinAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _getUserFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  // signin with email and password

  Future signinWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _getUserFromFireBaseUser(user);
    }catch(e){
      print('error is $e');
      return null;
    }
  }
  

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      await Database(uid: user.uid).updateUserData('member', '0', 100);
      return _getUserFromFireBaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // signout
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}