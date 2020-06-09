import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';
import 'package:tmapp/screens/MainFiles/admin/manageAdmin.dart';

import 'addemployee.dart';
import 'deleteemployee.dart';
import 'editSearchEmp.dart';

class AdminMain extends StatefulWidget {
  @override
  _AdminMainState createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryblue,
        title: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 42,
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
              Hero(
                tag: "AddEmployeeAdmin",
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                        )
                      ]),
                  margin: EdgeInsets.all(10),
                  child: Card(
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
                ),
              ),
              Hero(
                tag: 'EditEmployeeAdmin',
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                        )
                      ]),
                  margin: EdgeInsets.all(10),
                  child: Card(
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
                ),
              ),
              Hero(
                tag: 'DeleteEmployeeAdmin',
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                        )
                      ]),
                  margin: EdgeInsets.all(10),
                  child: Card(
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
                ),
              ),
              Hero(
                tag: 'ManageAdmin',
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                        )
                      ]),
                  margin: EdgeInsets.all(10),
                  child: Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ManageAdmin()),
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
                              child: Icon(
                                Icons.settings,
                                color: primaryblue,
                                size: 20,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(left: 5),
                              child: Text("Manage Profile",
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
