import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:final_binder/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  UserDetails details = new UserDetails(name: 'Suraj',designation: 'a',mobileNo: '11',bay_no: '2');

  @override
  Widget build(BuildContext context) {
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

              },
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: getCurrentUserDetailsFromSnapshot(context),
              builder: (context,snapshot){
                if(!snapshot.hasData) return Text('loading');
                return Column(
                  children: <Widget>[
                    Text(snapshot.data.documents[0]['designation']),
                    Text(snapshot.data.documents[0]['mobile_no']),
                    Text(snapshot.data.documents[0]['name']),
                    Text(snapshot.data.documents[0]['bay_no'])
                  ],
                );
              }
            )
          ],
        ),
      ),
    );
  }

  Stream<QuerySnapshot> getCurrentUserDetailsFromSnapshot(BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    print(uid);
    yield* Firestore.instance.collection("binder").document(uid).collection("user_details").snapshots();
  }
}
