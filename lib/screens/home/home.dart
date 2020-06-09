import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:final_binder/services/database.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mainFiles/myComplaints/addcomplaint.dart';

class Home extends StatefulWidget {
  final User user;
  Home({this.user});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final DatabaseServices _db = DatabaseServices();
  UserDetails currentUserDetail = new UserDetails();

  @override
  Widget build(BuildContext context) {

  UserDetails getCurrentUserDetailsFromSnapshot(QuerySnapshot snapshot){

  }

  return Scaffold(
      appBar: AppBar(
        title: Text("Binder Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              try {
                await _auth.signOut();
                print("Signed Out!");
              } catch (e) {
                print (e);
              }
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('add user detail'),
              onPressed: () async{
                //final uid = await Provider.of(context).auth.getCurrentUID();
//                await Firestore.instance.collection("binder").document((widget.user.uid).toString()).collection("user_details").add({
//                  'name': detail.name,
//                  'designation': detail.designation,
//                  'mobile_no': detail.mobileNo,
//                  'bay_no': detail.bay_no,
//                });
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: primaryblue,
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
      elevation: 25.0,
      onPressed: (){
        final String uid = (widget.user.uid).toString();
        Navigator.push(context, MaterialPageRoute(builder: (context) => addComplaint(user: widget.user,)));
    }),
    );
  }

  Stream<QuerySnapshot> getCurrentUserDetailsFromSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    print(uid);
    yield* Firestore.instance.collection("binder").document(uid).collection("user_details").snapshots();
  }
}
