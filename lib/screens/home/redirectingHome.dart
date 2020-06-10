import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/home.dart';
import 'package:final_binder/screens/home/navBarSelect.dart';
import 'package:final_binder/services/database.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:flutter/material.dart';

class RedirectingScreen extends StatelessWidget {
  final User user;

  const RedirectingScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServices(uid: user.uid).collectionReference
          .document((user.uid).toString())
          .collection("user_details").snapshots(),
      // ignore: missing_return
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return NavBarSelect(userDetails: UserDetails(
            uid: user.uid.toString(),
            name: snapshot.data.documents[0]['name'],
            authLevel: snapshot.data.documents[0]['designation'],
            bayNo: snapshot.data.documents[0]['bayNo'],
            mobileNo: snapshot.data.documents[0]['mobileNo'],
            department: snapshot.data.documents[0]['department'],
            email: snapshot.data.documents[0]['email'],
            password: snapshot.data.documents[0]['password'],
            personalId: snapshot.data.documents[0]['personalId'],
          ));
        }
      },
    );;
  }
}
