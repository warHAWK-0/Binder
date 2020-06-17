import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_Info.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../shared/CustomAppBar.dart';
import '../../../../shared/themes.dart';
import 'invalidPersonalNo.dart';

class DeleteEmployee extends StatefulWidget {
  @override
  _DeleteEmployeeState createState() => _DeleteEmployeeState();
}

class _DeleteEmployeeState extends State<DeleteEmployee> {
  bool loading = false;
  String userID="";
  List<UserDetails> allData = [];
  final db= Firestore.instance;
  void fetchDepartmentComplaints() async {
    setState(() {
      print(loading);
      loading = true;
      print("again"+loading.toString());
    });

    final QuerySnapshot usersList =
    await Firestore.instance.collection('binder').getDocuments();
    final List<DocumentSnapshot> docUsers = usersList.documents;
    allData.clear();
    for (DocumentSnapshot docUser in docUsers) {
      String uidUser = docUser.documentID;
      print(uidUser);
      final QuerySnapshot userComplaints = await Firestore.instance
          .collection('binder')
          .document(uidUser)
          .collection('user_details')
          .getDocuments();
      final List<DocumentSnapshot> docComplaints = userComplaints.documents;
      for (DocumentSnapshot docComplaint in docComplaints) {
        print(docComplaint.documentID + " => " );
        if (PID == docComplaint.data['personalId']) {
          print(PID); print(docComplaint.data['personalId']);
          userID= uidUser;
          UserDetails d = new UserDetails(
              name:docComplaint.data['name'],
              authLevel: docComplaint.data['authLevel'],
              uid: docComplaint.data['uid'],
              department: docComplaint.data['department'],
              mobileNo: docComplaint.data['mobileNo'],
              personalId: docComplaint.data['personalId'],
              email: docComplaint.data['email'],
              bayNo: docComplaint.data['bayNo'],
          );
          allData.add(d);
        }
      }
    }
    setState(() {
      loading = false;
    });
  }


  String PID = "";
  bool showDetailsContainer = false;
  bool detailsFound = false;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'EditEmployeeAdmin',
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
                          onPressed: () async{
                            await fetchDepartmentComplaints();
                            showDetailsContainer=true;
                            if(allData.length>0) {
                              setState(() {
                                loading = false;
                                detailsFound=true;
                              });
                            }
                            else{
                              setState(() {
                                loading = false;
                                detailsFound=false;
                              });
                            }
                          },
                          child: loading == true ? Loading() : Text(
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
                                child: Text("Name:                 "+ allData[0].name,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Personal No:      "+allData[0].personalId,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Bay No :              "+allData[0].bayNo,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Department:       "+allData[0].department,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Designation:       "+(allData[0].authLevel.toString()=="0"? "Operator Level":
                                allData[0].authLevel.toString()=="1"? "Supervisor Level":
                                allData[0].authLevel.toString()=="2"? " Admin": "Null"),
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Phone Number: "+allData[0].mobileNo,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Color(0xFF1467B3),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Text("Email ID:              "+allData[0].email,
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
                                  onPressed: () async{

                                    await db.collection('binder').document(userID).collection('user_details').document(allData[0].uid).delete();

                                    return Alert(
                                      context: context,
                                      type: AlertType.success,
                                      title: "Employee Deleted!",
                                      buttons: [
                                        DialogButton(
                                            child: Text(
                                              "Okay",
                                              style: TextStyle(color: Colors.white, fontSize: 20),
                                            ),
                                            onPressed: (){ Navigator.pop(context);},
                                          color: Color(0xFF1467B3),
                                        ),
                                      ],
                                    ).show();

                                  },
                                  child: Text(
                                    "Delete Employee",
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
