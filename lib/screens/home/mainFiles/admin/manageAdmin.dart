import 'package:final_binder/services/auth.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';

import 'homepageadmin.dart';
import 'resetPasswordAdmin.dart';

class ManageAdmin extends StatefulWidget {
  @override
  _ManageAdminState createState() => _ManageAdminState();
}

class _ManageAdminState extends State<ManageAdmin> {

  final AuthService _auth = AuthService();

  String _email;
  Future<bool> _onBackPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePageAdmin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'ManageAdmin',
      child: Scaffold(
        appBar: CustomAppBar(
          child: Text(
            'Manage Profile',
            style: titleText,
          ),
          backIcon: true,
          elevation: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: FlatButton(
                    color: primaryblue,
                    textColor: Colors.white,
                    disabledColor: Colors.grey,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () {

                    },
                    child: Text(
                      "Reset Password",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: OutlineButton(
                    textColor: primaryblue,
                    disabledTextColor: Colors.black,
                    padding: EdgeInsets.all(8.0),
                    onPressed: () async {
                      try {
                        await _auth.signOut();
                        Navigator.pop(context);
                      } catch (e) {
                        print (e);
                      }
                    },
                    borderSide: BorderSide(color: Color(0xFF1467B3)),
                    child: Text(
                      "Log Out",
                      style: TextStyle(
                          fontSize: 15.0, color: Color(0xFF1467B3)),
                    ),
                  ),
                )
              ],
            ),
          ),
            ),
          ),
    );
  }
}
