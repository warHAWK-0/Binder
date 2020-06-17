import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/database.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged =>
      _auth.onAuthStateChanged.map(
            (FirebaseUser user) => user?.uid,
      );

  //
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //get UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  //SignIn Using Email Password
  Future singnInUsingEmail(String email, String password) async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = authResult.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
  //.sendPasswordResetEmail(email: email)

  Widget buildUserCreatedDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Employee Successfully Created!'),
      content: Container(
        child: Image.asset("assets/images/blue_tick.png"),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          textColor: primaryblue,
          child: const Text('Ok!'),
        ),
      ],
    );
  }

  // Email & Password Sign Up
  Future createUserWithEmailAndPassword(String email, String password, UserDetails userDetails,BuildContext context) async {
    try{
      print("Step1");
      print(getCurrentUID().asStream());
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Step2");
      FirebaseUser user = authResult.user;
      //add User Details
      await DatabaseServices(uid: user.uid).initiateDocument();
      print("Step3");
      await DatabaseServices(uid: user.uid).updateUserData(UserDetails(
        name: userDetails.name,
        uid: user.uid,
        authLevel: userDetails.authLevel,
        department: userDetails.department,
        mobileNo: userDetails.mobileNo,
        personalId: userDetails.personalId,
        email: userDetails.email,
        //password: "123456",
        bayNo: userDetails.bayNo,
      ));
      print("Step4");
      //buildUserCreatedDialog(context);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e);
      return null;
    }
  }

  //sign Out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      return null;
    }
  }
}
