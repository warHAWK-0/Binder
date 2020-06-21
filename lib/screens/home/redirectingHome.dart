import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_data.dart';
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
      stream: Firestore.instance
          .collection("user_details").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Loading();
        } else {
          return NavBarSelect(userDetails: UserDetails(
            uid: user.uid.toString(),
            name: snapshot.data.documents[0]['name'],
            authLevel: snapshot.data.documents[0]['authLevel'],
            bayNo: snapshot.data.documents[0]['bayNo'],
            mobileNo: snapshot.data.documents[0]['mobileNo'],
            department: snapshot.data.documents[0]['department'],
            email: snapshot.data.documents[0]['email'],
            typeofOperator: snapshot.data.documents[0]['typeOfOperator'],
            firstLogin: snapshot.data.documents[0]['firstLogin'],
            personalId: snapshot.data.documents[0]['personalId'],
          ));
        }
      },
    );
  }
}
