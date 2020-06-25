import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Binder/models/user_data.dart';
import 'package:Binder/services/auth.dart';
import 'package:Binder/shared/loading.dart';
import 'package:Binder/widgets/SizeConfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../shared/CustomAppBar.dart';
import '../../../../shared/themes.dart';

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
            style: TextStyle(color: Color(0xFF1467B3), fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        )
      ],
    ).show();
  }

  bool loading = false;
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return loading == false ? WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            backIcon: false,
            child: Text(
              'Profile',
              style: titleText,
              textAlign: TextAlign.center,
            )),
        body: SingleChildScrollView(
          child: Container(
            height: SizeConfig.safeBlockVertical *90,
            width: SizeConfig.safeBlockHorizontal *100,
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.name, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Name  ', style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.authLevel
                                .toString() ==
                                "0"
                                ? "Operator"
                                : widget.userDetails.authLevel
                                .toString() ==
                                "1"
                                ? "Supervisor"
                                : widget.userDetails.authLevel
                                .toString() ==
                                "2"
                                ? " Admin"
                                : "Null", style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54,),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Designation  ',style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.personalId, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Personal ID  ',style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.department, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Department  ',style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.email, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Email ',style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          height: 60,
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20),
                            width: 350,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color: Color(0xFF1467B3), width: 2.0),
                            ),
                            child: Text(widget.userDetails.mobileNo, style: TextStyle(fontWeight: FontWeight.w700,color: Colors.black54),),
                          ),
                        ),
                        Positioned(
                          left: 29,
                          bottom: 40,
                          child: Container(color: Colors.white, child: Text('  Mobile No.  ',style: TextStyle(fontSize: 12,color: Colors.black38),)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    widget.userDetails.firstLogin == "true" ? Container(
                      width: double.infinity,
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
                            setState(() {
                              loading = true;
                            });
                            await Firestore.instance.collection("user_details")
                                .document(widget.userDetails.uid).collection(widget.userDetails.uid)
                                .document(widget.userDetails.uid).updateData({
                              'firstLogin' : 'false',
                            });
                            await _auth.signOut();
                            dynamic result = await _auth.singnInUsingEmail("binderproject9@gmail.com", "123456");
                            if(result != null){
                            }
                          } catch (e) {
                          }
                        },
                        child: Text(
                          "Sign out & Return to Admin Console",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ) : SizedBox(
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
                            await _auth.sendPasswordResetEmail(
                                (widget.userDetails.email).toString());
                          } catch (e) {
                          }
                        },
                        child: Text(
                          "Reset Password",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ),
                    widget.userDetails.firstLogin == "false" ? SizedBox(
                      height: 10,
                    ) : Container(),
                    widget.userDetails.firstLogin == "false" ? Divider(
                      color: Color(0xFF1467B3),
                      thickness: 1.3,
                    ) : Container(),
                    widget.userDetails.firstLogin == "false" ? SizedBox(
                      height: 10,
                    ) : Container(),
                    widget.userDetails.firstLogin == "false" ? SizedBox(
                      width: double.infinity,
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
                          }
                        },
                        borderSide: BorderSide(color: Color(0xFF1467B3)),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xFF1467B3)),
                        ),
                      ),
                    ) : Container()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ) : Loading();
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}
