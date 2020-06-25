import 'package:Binder/models/user_data.dart';
import 'package:Binder/services/database.dart';
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

  // Email & Password Sign Up
  Future createUserWithEmailAndPassword(String email, String password, UserDetails userDetails,BuildContext context) async {
    try{
      print(getCurrentUID().asStream());
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser user = authResult.user;
      //add User Details
      await DatabaseServices(uid: user.uid).initiateDocument();
      await DatabaseServices(uid: user.uid).updateUserData(UserDetails(
        name: userDetails.name,
        lineNo: userDetails.lineNo,
        uid: user.uid,
        authLevel: userDetails.authLevel,
        department: userDetails.department,
        mobileNo: userDetails.mobileNo,
        personalId: userDetails.personalId,
        email: userDetails.email,
        typeofOperator: userDetails.typeofOperator,
        firstLogin: userDetails.firstLogin,
        bayNo: userDetails.bayNo,
      ));
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
