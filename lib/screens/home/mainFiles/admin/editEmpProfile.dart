import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/CustomAppBar.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';
import 'dart:io';

import 'editSearchEmp.dart';

enum TypeOfEmp { Electrical, Mechanical, Nothing }

class EditEmpProfile extends StatefulWidget {
  @override
  _EditEmpProfileState createState() => _EditEmpProfileState();
}

class _EditEmpProfileState extends State<EditEmpProfile> {
  final _formkey = GlobalKey<FormState>();
  String id = " ";
  String name = " ";
  String phoneNo = " ";
  String email = " ";
  TypeOfEmp emp = TypeOfEmp.Nothing;
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
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    onSaved: (value) => name = value,
                  ), //Name
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
                    onSaved: (value) => id = value,
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
                        value == null ? 'Enter Block No.' : null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    // style: TextStyle(color: Color(0xFF1467B3)),
                    decoration: InputDecoration(
                      hintText: "Department",
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
                    //  style: TextStyle(color: Color(0xFF1467B3)),
                    decoration: InputDecoration(
                      hintText: "Designation",
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
                  ),
                  SizedBox(
                    height: 20,
                  ), //Designation
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
                    onSaved: (value) => phoneNo = value,
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
                    onSaved: (input) => email = input,
                  ),
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
                          /**/
                        }
                      },
                      child: Text(
                        "Save Changes",
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
                              builder: (context) => EditSearchEmp()),
                        );
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 15.0, color: Color(0xFF1467B3)),
                      ),
                      borderSide: BorderSide(color: Color(0xFF1467B3)),
                    ),
                  ), //Cancel Button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
