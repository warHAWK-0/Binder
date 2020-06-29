import 'package:Binder/models/user.dart';
import 'package:Binder/models/user_data.dart';
import 'package:Binder/screens/home/navBarSelect.dart';
import 'package:Binder/services/database.dart';
import 'package:Binder/shared/loading.dart';
import 'package:flutter/material.dart';

class RedirectingScreen extends StatelessWidget {
  final User user;

  const RedirectingScreen({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DatabaseServices(uid: user.uid.toString()).collectionReference.document(user.uid.toString()).collection(user.uid.toString()).snapshots(),
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
