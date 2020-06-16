import 'dart:io';

import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_responsive_screen/flutter_responsive_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../shared/CustomAppBar.dart';
import '../../../../shared/themes.dart';
import 'resetPass.dart';

class ProfileMain extends StatefulWidget {

  final UserDetails userDetails;

  const ProfileMain({Key key, this.userDetails}) : super(key: key);

  @override
  _ProfileMainState createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {




  Future<bool> _onBackPressed() {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "Are you Sure?",
      desc: "Do you want to exit the App?",
      buttons: [
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => exit(0),
          color: Color(0xFF1467B3),
        ),
        DialogButton(
          child: Text(
            "No",
            style: TextStyle(color:Color(0xFF1467B3), fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        )
      ],
    ).show();
  }



  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: CustomAppBar(backIcon: false, child: Text('Profile',style: titleText,textAlign: TextAlign.center,)),
          body: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Name:              ",style: TextStyle(fontSize: 16),),
                            Flexible(
                              child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: (widget.userDetails.name.toString()),
                                    hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                  )

                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Designation:   ",style: TextStyle(fontSize: 16),),
                              Flexible(
                                child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: (widget.userDetails.authLevel.toString()=="0"? "Operator":
                                        widget.userDetails.authLevel.toString()=="1"? "Supervisor":
                                        widget.userDetails.authLevel.toString()=="2"? " Admin": "Null"),
                                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                    )

                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 10,),
                        Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Personal ID:    ",style: TextStyle(fontSize: 16),),
                              Flexible(
                                child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: (widget.userDetails.personalId.toString()),
                                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                    )

                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Department:   ",style: TextStyle(fontSize: 16),),
                            Flexible(
                              child: TextField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                      hintText: (widget.userDetails.department.toString().inCaps),
                                    hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                  )

                              ),
                            )
                          ],
                        )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Email:              ",style: TextStyle(fontSize: 16),),
                              Flexible(
                                child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: (widget.userDetails.email.toString()),
                                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                    )

                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Mobile:            ",style: TextStyle(fontSize: 16),),
                              Flexible(
                                child: TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                        hintText: (widget.userDetails.mobileNo.toString()),
                                      hintStyle: TextStyle(fontWeight: FontWeight.w700),
                                    )

                                ),
                              )
                            ],
                          )
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      SizedBox(
                        width: 400,
                        height: 45,
                        child: FlatButton(
                          color: Color(0xFF1467B3),
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Colors.blueAccent,
                          onPressed: () async {
                            try {
                              await _auth.sendPasswordResetEmail((widget.userDetails.email).toString());
                            } catch (e) {
                              print (e);
                            }
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
                      Divider(
                        color: Color(0xFF1467B3),
                        thickness: 1.3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 400,
                        height: 45,
                        child: OutlineButton(
                          textColor: Color(0xFF1666f0),
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          splashColor: Color(0xffd1e3ff),
                          onPressed: () async {
                            try {
                              await _auth.signOut();
                            } catch (e) {
                              print (e);
                            }
                          },
                          borderSide: BorderSide(color: Color(0xFF1467B3)),
                          child: Text(
                            "Sign Out",
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
          ),
        ),
    );
  }
}


extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}
