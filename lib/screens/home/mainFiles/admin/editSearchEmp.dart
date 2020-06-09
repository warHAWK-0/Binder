import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/CustomAppBar.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';
import 'dart:io';

import 'editEmpProfile.dart';

class EditSearchEmp extends StatefulWidget {
  @override
  _EditSearchEmpState createState() => _EditSearchEmpState();
}

class _EditSearchEmpState extends State<EditSearchEmp> {

  String PID = "";
  bool showDetailsContainer = false;
  bool detailsFound = false;

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App?'),
              actions: <Widget>[
                OutlineButton(
                  child: Text('Yes'),
                  onPressed: () => exit(0),
                ),
                OutlineButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'EditEmployeeAdmin',
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(
          child: Text(
            'Edit an employee',
            style: titleText,
          ),
          backIcon: true,
          elevation: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Personal No.",
                      hintStyle: TextStyle(color: Color(0xFF1467B3)),
                      filled: true,
                      fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(93, 153, 252, 100)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  Color.fromRGBO(223, 232, 247, 100)) //dfe8f7
                          ),
                    ),
                    onChanged: (String text){
                      PID = text;
                    },
                    onSubmitted: (String text){
                      PID = text;
                      // getter method to get details of the PID
                      // and turn details found FLAG to true
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: FlatButton(
                      color: Color(0xFF1467B3),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () {
                        setState(() {
                          showDetailsContainer = true;
                          if(PID == "pid1"){
                            detailsFound = true;
                          }
                          else{
                            detailsFound = false;
                          }
                        });
                      },
                      child: Text(
                        "Get Details",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                  showDetailsContainer == true ? Container(
                    margin: EdgeInsets.symmetric(vertical: 15),
                    child: detailsFound == false ? Container(
                      height: 100,
                      child: Stack(
                        children: <Widget>[
                          Align(
                            child: Container(
                              child: Image.asset(
                                  'assets/images/InvalidPersonalNo.png',
                                  height: 50,
                                  fit: BoxFit.cover),
                            ),
                            alignment: Alignment.center,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              child: Text(
                                "Invalid Personal No",
                                style: TextStyle(
                                    fontSize: 15.0, color: primaryblue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ) : Container(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          /**/
                        },
                        child: Container(
                          height: 250,
                          margin:
                          EdgeInsets.only(top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            //padding: EdgeInsets.only(left: 5, top: 10),
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Name ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Personal No. ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Block No. ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Department ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Designation ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Phone Number ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Email ID ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 45,
                                child: FlatButton(
                                  color: Color(0xFF1467B3),
                                  textColor: Colors.white,
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.black,
                                  padding: EdgeInsets.all(8.0),
                                  splashColor: Colors.blueAccent,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditEmpProfile()),
                                    );
                                  },
                                  child: Text(
                                    "Edit",
                                    style: TextStyle(fontSize: 15.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
