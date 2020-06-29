import 'package:Binder/models/user_data.dart';
import 'package:Binder/services/auth.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'addemployee.dart';
import 'deleteemployee.dart';
import 'editSearchEmp.dart';

class AdminMain extends StatefulWidget {

  final UserDetails userDetails;

  AdminMain({Key key, this.userDetails}) : super(key: key);

  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryblue,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/Logo/LogoWhite/logoFullWhite.png'),
              fit: BoxFit.fitHeight,
            )),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0,color: Colors.grey[200]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(3.0, 2.0),
                      )
                    ]),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddEmployee()),
                    );
                  },
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //  margin: EdgeInsets.only(top: 15, bottom: 15, left: 50),
                          child: Image.asset('assets/images/AddEmpIcon.png',
                              fit: BoxFit.cover, height: 20),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(left: 5),
                            child: Text("Add an Employee",
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: primaryblue,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0,color: Colors.grey[200]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(3.0, 2.0),
                      )
                    ]),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditSearchEmp()),
                    );
                  },
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //  margin: EdgeInsets.only(top: 15, bottom: 15, left: 50),
                          child: Image.asset(
                              'assets/images/EditEmpIcon.png',
                              fit: BoxFit.cover,
                              height: 24),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text("Edit an Employee",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: primaryblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0,color: Colors.grey[200]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(0.0, 2.0),
                      )
                    ]),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DeleteEmployee()),
                    );
                  },
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(top: 15, bottom: 15, left: 45),
                          alignment: Alignment.centerRight,
                          child: Image.asset(
                              'assets/images/DeleteEmpIcon.png',
                              fit: BoxFit.cover,
                              height: 24),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 5),
                          child: Text("Delete an Employee",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: primaryblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1.0,color: Colors.grey[200]),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey[200],
                        offset: Offset(3.0, 2.0),
                      )
                    ]),
                margin: EdgeInsets.all(10),
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    return Alert(
                      context: context,
                      type: AlertType.warning,
                      title: "Do you want to Logout?",
                      buttons: [
                        DialogButton(
                          child: Text(
                            "Yes",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () async {
                            try {
                              await _auth.signOut();
                              Navigator.pop(context);
                            } catch (e) {
                            }
                          },
                          color: Colors.red,
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
                  },
                  child: Container(
                    height: 70,
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(top: 15, bottom: 15, left: 45),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.exit_to_app,
                            color: primaryblue,
                            size: 20,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 5),
                          child: Text("Logout",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: primaryblue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
