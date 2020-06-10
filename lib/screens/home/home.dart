import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:final_binder/services/database.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final User user;
  final UserDetails userd;
  Home({this.user,this.userd});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final DatabaseServices _db = DatabaseServices();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        title: Text(widget.userd.uid),
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
                await Firestore.instance.collection("binder").document((widget.user.uid).toString())
                    .collection("user_details").document((widget.user.uid).toString()).setData({
                  'name': "New name",
                  'designation': "New designation",
                  'mobile_no': "mobileNo",
                  'bay_no': "bay_no",
                });
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
//        Navigator.push(context, MaterialPageRoute(builder: (context) {
//          return addComplaint();
//        }));
    }),
    );
  }
}
