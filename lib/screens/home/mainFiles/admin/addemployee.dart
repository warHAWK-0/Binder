import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/screens/home/mainFiles/admin/homepageadmin.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/user.dart';
import '../../../../services/auth.dart';
class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

enum TypeOfEmp { Electrical, Mechanical, Nothing }

class _AddEmployeeState extends State<AddEmployee> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  TypeOfEmp emp = TypeOfEmp.Nothing;
  String id = " ";
  String name = " ";
  String phoneNo = " ";
  String email = " ";
  String block = "";
  String dept = "";
  String designation = "";

  @override
  void initState() {
    super.initState();
    block = '';
    dept = '';
    designation = '';
  }

  List<String> blockNo = ["D5"];
  List<String> departments = ["Production", "Maintenance", "AME"];
  List<String> designations = [
    "Section Incharge",
    "Line Manager",
    "Supervisor",
    "Operator/Engineer",
    "Temporary Operator",
  ];



  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'AddEmployeeAdmin',
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          child: Text(
              'Add an employee',
            style: titleText,
          ),
          backIcon: true,
          elevation: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: EdgeInsets.all(30.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
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
                      validator: (value) {
                        Pattern p = r'^[a-zA-Z.]*$';
                        RegExp regex = new RegExp(p);
                        if (value.isEmpty)
                          return 'Enter Name';
                        else if (!regex.hasMatch(value)) {
                          return 'Not a valid name';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ), //Name//validator
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Personal No.",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
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
                      validator: (value) =>
                      value.isEmpty ? 'Enter Personal No.' : null,
                      onChanged: (value) {
                        setState(() {
                          id = value;
                        });
                      },
                    ), //Personal No.
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        hintText: "Block No.",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding: const EdgeInsets.only(
                            left: 5.0, bottom: 5.0, top: 5.0),
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
                      value: block.isNotEmpty ? block : null,
                      onSaved: (value) {
                        setState(() {
                          block = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          block = value;
                        });
                      },
                      items: blockNo.map((item) {
                        return DropdownMenuItem<String>(
                            child: new Text(item), value: item);
                      }).toList(),
                      validator: (value) =>
                      value == null ? 'Enter Block no.' : null,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      //   style: TextStyle(color: Color(0xFF1467B3)),
                      decoration: InputDecoration(
                        hintText: "Department",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding: const EdgeInsets.only(
                            left: 5.0, bottom: 5.0, top: 5.0),
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
                      value: dept.isNotEmpty ? dept : null,
                      onSaved: (value) {
                        setState(() {
                          dept = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          dept = value;
                        });
                      },
                      items: departments.map((item) {
                        return DropdownMenuItem<String>(
                            child: new Text(item), value: item);
                      }).toList(),
                      validator: (value) =>
                      value == null ? 'Enter Department' : null,
                    ), //Department
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButtonFormField(
                      // style: TextStyle(color: Color(0xFF1467B3)),
                      decoration: InputDecoration(
                        hintText: "Designation",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding: const EdgeInsets.only(
                            left: 5.0, bottom: 5.0, top: 5.0),
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
                      value: designation.isNotEmpty ? designation : null,
                      onSaved: (value) {
                        setState(() {
                          designation = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          designation = value;
                        });
                      },
                      items: designations.map((item) {
                        return DropdownMenuItem<String>(
                            child: new Text(item), value: item);
                      }).toList(),
                      validator: (value) =>
                      value == null ? 'Enter Designation' : null,
                    ), //Designation
                    Container(
                      child: designation == "Operator/Engineer"
                          ? new Align(
                        alignment: Alignment.topRight,
                        child: new Row(
                          children: <Widget>[
                            new Text(
                              'Electrical',
                              style: new TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  color: Color(0xFF1467B3)),
                            ),
                            new Radio(
                              value: TypeOfEmp.Electrical,
                              groupValue: emp,
                              onChanged: (TypeOfEmp value) {
                                setState(() {
                                  emp = value;
                                });
                              },
                            ),
                            new Text(
                              'Mechanical',
                              style: new TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 16.0,
                                  color: Color(0xFF1467B3)),
                            ),
                            new Radio(
                              value: TypeOfEmp.Mechanical,
                              groupValue: emp,
                              onChanged: (TypeOfEmp value) {
                                setState(() {
                                  emp = value;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                          : SizedBox(
                        height: 20,
                      ),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
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
                      validator: (value) {
                        Pattern p = '[0-9]{10}';
                        RegExp regex = new RegExp(p);
                        if (value.isEmpty)
                          return 'Enter Phone No.';
                        else if (!regex.hasMatch(value)) {
                          return 'Not a valid Phone No.';
                        } else
                          return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          phoneNo = value;
                        });
                      },
                    ), //Phone No
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Color(0xFF1467B3)),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
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
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Enter email';
                        else if (!value.contains('@'))
                          return 'Not a valid email';
                        else
                          return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ), //Email
                    SizedBox(
                      height: 30,
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
                          if (_formkey.currentState.validate()) {
                            print(
                                "$id=>$name=>$phoneNo=>$email=>$block=>$designation=>$dept=>$emp");
                          }
                        },
                        child: Text(
                          "Add Employee",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ), //Add Employee
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
                        splashColor: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePageAdmin()),
                          );
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 15.0, color: Color(0xFF1467B3)),
                        ),
                        borderSide: BorderSide(color: Color(0xFF1467B3)),
                      ),
                    ),
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
