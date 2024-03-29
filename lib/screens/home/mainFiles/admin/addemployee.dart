import 'package:Binder/models/user_data.dart';
import 'package:Binder/shared/CustomAppBar.dart';
import 'package:Binder/shared/loading.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/auth.dart';

class AddEmployee extends StatefulWidget {
  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

enum TypeOfEmp { Electrical, Mechanical, Nothing }

class _AddEmployeeState extends State<AddEmployee> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  TypeOfEmp typeOfOp = TypeOfEmp.Nothing;
  String personalId = " ";
  String name = " ";
  String phoneNo = " ";
  String email = " ";
  String bayNo = "";
  String dept = "";
  String designation = "";
  bool userCreated = false;

  @override
  void initState() {
    super.initState();
    bayNo = '';
    dept = '';
    designation = '';
  }

  Widget buildUserCreatedDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('Employee Successfully Created!'),
      content: Container(
        child: Image.asset("assets/images/blue_tick.png"),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          textColor: primaryblue,
          child: const Text('OK'),
        ),
      ],
    );
  }

  bool isLoading = false;
  List<String> bayNoList = ["Bay2","Bay3","Bay4","Bay5","Bay6","Bay7","Bay8"];
  List<String> departments = ["Production", "Maintenance"];
  List<String> designations = [
    "Section Incharge",
    "Line Manager",
    "Supervisor",
    "Operator/Engineer",
    "Temporary Operator",
  ];

  List<String> linetype = [
    "4SP Krauseco Cylinder Headline",
    "4SP Makino Cylinder Headline",
    "2.2L Cylinder Headline",
    "5L Cylinder Headline",
    "3l/3.3L Cylinder Headline",
    "Hoists and Cranes",
    "Mancooling Fan"
  ];
  String lineNo = "";


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
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      Pattern p = r'^[a-z A-Z ]*$';
                      RegExp regex = new RegExp(p);
                      if (value.isEmpty)
                        return 'Enter Name';
                      else if (!regex.hasMatch(value)) {
                        return 'Not a valid name';
                      } else
                        return null;
                    },
                    onChanged: (value){
                      setState(() {
                        name = value;
                      });
                    },
                    onSaved: (value) => name = value,
                  ), //Name//validator
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Personal Id",
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
                    onSaved: (value){
                      setState(() {
                        personalId = value;
                      });
                    },
                    onChanged: (value){
                      setState(() {
                        personalId = value;
                      });
                    },
                  ), //Personal No.
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    // style: TextStyle(color: Color(0xFF1467B3)),
                    decoration: InputDecoration(
                      hintText: "Line No.",
                      hintStyle:
                      TextStyle(color: Color(0xFF1467B3), fontSize: 16),
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
                    value: lineNo.isNotEmpty ? lineNo : null,
                    onSaved: (value) {
                      setState(() {
                        lineNo = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        lineNo = value;
                      });
                    },
                    items: linetype.map((item) {
                      return DropdownMenuItem<String>(
                          child: new Text(item), value: item);
                    }).toList(),
                    validator: (value) => value == null ? '' : null,
                  ), //Department
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                      hintText: "Bay Number",
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
                    value: bayNo.isNotEmpty ? bayNo : null,
                    onSaved: (value) {
                      setState(() {
                        bayNo = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        bayNo = value;
                      });
                    },
                    items: bayNoList.map((item) {
                      return DropdownMenuItem<String>(
                          child: new Text(item), value: item);
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'Enter Bay Number' : null,
                  ),
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
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
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
                  ),
                  Container(
                    child: designation == "Operator/Engineer"
                        ? new Align(
                            alignment: Alignment.bottomRight,
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
                                  groupValue: typeOfOp,
                                  onChanged: (TypeOfEmp value) {
                                    setState(() {
                                      typeOfOp = value;
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
                                  groupValue: typeOfOp,
                                  onChanged: (TypeOfEmp value) {
                                    setState(() {
                                      typeOfOp = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 20,
                          ),
                  ), //RadioButton for Op/Eng only
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
                    onChanged: (value){
                      setState(() {
                        phoneNo = value;
                      });
                    },
                    onSaved: (value){
                      setState(() {
                        phoneNo = value;
                      });
                    },
                  ), //Phone No
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 80,
                    width: double.infinity,
                    child: TextFormField(
                      validator: (value) {
                        Pattern p = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                        RegExp regex = new RegExp(p);
                        if (!regex.hasMatch(value)) {
                          return 'Enter a valid email';
                        } else
                          return null;
                      },
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      decoration: InputDecoration(
                        hintText: "Email Address",
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

                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: isLoading ? Loading() : FlatButton(
                      color: Color(0xFF1467B3),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () async{
                        setState(() {
                          isLoading = true;
                        });
                        String type =typeOfOp.toString().substring(10);
                        final UserDetails userDetails = UserDetails(
                        name: name,
                        uid: '',
                        firstLogin: "true",
                        typeofOperator: type,
                        lineNo: lineNo,
                        authLevel: (designation == "Operator/Engineer" || designation == "Temporary Operator") ? "0"
                            : (designation == "Section Incharge")? "4" : (designation == "Line Manager")?"3": ( designation == "Supervisor") ? "1"
                            : (designation == "Admin") ? "2" : "0",
                        department: dept.toLowerCase(),
                        mobileNo: phoneNo,
                        personalId: personalId,
                        email: email,
                        bayNo: bayNo,
                        );
                        print(email);
                        if (_formkey.currentState.validate()) {
                          dynamic result = await _auth.createUserWithEmailAndPassword(email, '123456',userDetails,context);
                          if(result == null){
                            setState(() {
                              userCreated = false;
                            });
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Cannot Create User!',style: TextStyle(fontFamily: 'Roboto',fontSize: 20,color: Colors.black)),
                                content: Container(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: email,style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.red)),
                                        TextSpan(text: " is already been taken or not a valid email address.",style: TextStyle(fontFamily: 'Roboto',fontSize: 16,color: Colors.black)),
                                      ]
                                    ),
                                  )
                                  //Text(email + " is already been taken or not a valid email address.",),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    textColor: primaryblue,
                                    child: const Text('OK'),
                                  ),
                                ],
                              )
                            );
                          }else{
                            setState(() {
                              userCreated = true;
                            });
                            Navigator.pop(context);
                          }
                        }
                        setState(() {
                          isLoading = false;
                        });
                        return userCreated == true ? showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Row(
                                    children: <Widget>[
                                      Container(
                                        height: 35,
                                        width: 35,
                                        child: Image.asset("assets/images/blue_tick.png"),
                                      ),
                                      Text('Employee Successfully Created!',style: TextStyle(fontSize: 12),),
                                    ],
                                  ),
                                  content: Container(
                                    child: Text('For confirmation purposes you are redirected to the new user. Please verify details.'),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      textColor: primaryblue,
                                      child: const Text('Ok!'),
                                    ),
                                  ],
                                )
                        ) : null;
                        },
                      child: Text(
                        "Add Employee",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ), //Add Employee//Cancel Button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
