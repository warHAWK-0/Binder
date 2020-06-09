import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/CustomAppBar.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';

import 'invalidPersonalNo.dart';

class DeleteEmployee extends StatefulWidget {
  @override
  _DeleteEmployeeState createState() => _DeleteEmployeeState();
}

class _DeleteEmployeeState extends State<DeleteEmployee> {

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'DeleteEmployeeAdmin',
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: CustomAppBar(
          child: Text(
            'Delete an employee',
            style: titleText,
          ),
          backIcon: true,
          elevation: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Personal No.",
                      hintStyle: TextStyle(color: Color(0xFF1467B3)),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 15.0, top: 15.0),
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
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InvalidPersonalNo()),
                          );
                          print("Invalid PersonalNo");
                        },
                        child: Container(
                          height: 250,
                          margin:
                              EdgeInsets.only(top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            // padding: EdgeInsets.only(left: 5, top: 10),
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
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
                            ],
                          ),
                        ),
                      ),
                    ),
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
                      onPressed: () {
                        /*...*/
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
