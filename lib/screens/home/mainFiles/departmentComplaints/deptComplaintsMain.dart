import 'dart:io';
import 'package:Binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Binder/models/complaint.dart';
import 'package:Binder/models/user_data.dart';
import 'package:Binder/shared/CustomAppBar.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class deptComplaints extends StatefulWidget {
  final UserDetails userDetails;
  const deptComplaints({Key key, this.userDetails}) : super(key: key);
  @override
  _deptComplaintsState createState() => _deptComplaintsState();
}

// ignore: camel_case_types
class _deptComplaintsState extends State<deptComplaints> {

  bool hasComplaint = true;

  Future<bool> _onbackpressed() {
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

  String val1 = "status";
  String val2 = 'raised';
  String filterValue = "Status";
  String filteringValue = "Raised";
  List<String> filters = ['Status','Line Number','Type of Issue'];
  List<String> statusValues = ['Raised','Ongoing','Pending'];
  List<String> lineNumberValues = ["4SP Krauseco Cylinder Headline", "4SP Makino Cylinder Headline", "2.2L Cylinder Headline",
    "5L Cylinder Headline", "3l/3.3L Cylinder Headline", "Hoists and Cranes", "Mancooling Fan"];
  List<String> typeOfIssueValues = ['Mechanical Issue','Electrical Issue'];

  @override
  Widget build(BuildContext context) {

    print(val1+val2);
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
            backIcon: false,
            child: Text(
              'My Complaints',
              style: titleText,
            )),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              height: 95,
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Filter by :\t\t\t',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryblue,
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.grey[200]),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(3.0, 2.0),
                              )
                            ]),
                        child: DropdownButton<String>(
                          value: filterValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          onChanged: (String val){
                            setState(() {
                              if(val == "Status"){
                                filterValue = val;
                                val1 = "status";
                                filteringValue = "Raised";
                                val2 = 'raised';
                              }
                              else if(val == "Line Number"){
                                filterValue = val;
                                val1 = "lineNo";
                                filteringValue = "4SP Krauseco Cylinder Headline";
                                val2 = "4SP Krauseco Cylinder Headline";
                              }
                              else if(val == 'Type of Issue'){
                                filterValue = val;
                                val1 = "typeofIssue";
                                filteringValue = 'Mechanical Issue';
                                val2 = 'Mechanical Issue';
                              }
                            });
                            print(val1);
                          },
                          underline: Container(),
                          items: filters.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                  child: Text(value)
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '$filterValue : \t\t\t',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryblue,
                        ),
                      ),
                      val1 == "status" ? Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.grey[200]),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(3.0, 2.0),
                              )
                            ]),
                        child: DropdownButton<String>(
                            value: filteringValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            onChanged: (String val){
                              setState(() {
                                if(val == "Raised"){
                                  filteringValue = val;
                                  val2 = "raised";
                                }
                                else if(val == "Ongoing"){
                                  filteringValue = val;
                                  val2 = "ongoing";
                                }
                                else if(val == "Pending"){
                                  filteringValue = val;
                                  val2 = "pending";
                                }
                              });
                            },
                            underline: Container(),
                            items: statusValues.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(value)
                                ),
                              );
                            }).toList()
                        ),
                      )
                          : val1 == "lineNo" ? Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.grey[200]),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(3.0, 2.0),
                              )
                            ]),
                        child: DropdownButton<String>(
                            value: filteringValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            onChanged: (String val){
                              setState(() {
                                filteringValue = val;
                                val2 = val;
                              });
                            },
                            underline: Container(),
                            items: lineNumberValues.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(value)
                                ),
                              );
                            }).toList()
                        ),
                      )
                          : Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1.0,color: Colors.grey[200]),
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey[200],
                                offset: Offset(3.0, 2.0),
                              )
                            ]),
                        child: DropdownButton<String>(
                            value: filteringValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            onChanged: (String val){
                              setState(() {
                                filteringValue = val;
                                val2 = val;
                              });
                            },
                            underline: Container(),
                            items: typeOfIssueValues.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Text(value)
                                ),
                              );
                            }).toList()
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(top: 5),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection("departmentComplaints")
                          .where(val1,isEqualTo: val2)
                          .orderBy('startDate', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: MediaQuery.of(context).size.height/25,
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: SpinKitFadingCircle(
                                size: 60,
                                color: primaryblue,
                              ),
                            ),
                            Text(
                              'Looking for complaints...',
                              style: TextStyle(
                                color: primaryblue,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                            : snapshot.data.documents.length == 0 ? Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: MediaQuery.of(context).size.width/6,),
                                      Container(
                                        height: MediaQuery.of(context).size.height/2.4,
                                        width: MediaQuery.of(context).size.width/1.3,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage('assets/images/sitting-4.png'),fit: BoxFit.fill
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text('Looks like you do not have any complaints here.',style: TextStyle(
                                    color: primaryblue,
                                    fontSize: 15,
                                  ),
                                  ),
                                  SizedBox(
                                    height: 60,
                                  )
                                ],
                              ),
                        )
                            : ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (_, index) {
                                return snapshot.data.documents[index]['status'] != "finsished" ? CustomComplaintCard(
                                  userDetails: widget.userDetails,
                                  complaint: Complaint(
                                    remark: snapshot.data.documents[index]['remark'],
                                    complaintId: snapshot.data.documents[index]['complaintId'],
                                    assignedDate: snapshot.data.documents[index]['assignedDate'],
                                    assignedTime: snapshot.data.documents[index]['assignedTime'],
                                    assignedTo: snapshot.data.documents[index]['assignedTo'],
                                    assignedToUid: snapshot.data.documents[index]['assignedToUid'],
                                    assignedBy: snapshot.data.documents[index]['assignedBy'],
                                    mobileNo: snapshot.data.documents[index]['mobileNo'],
                                    department: snapshot.data.documents[index]['department'],
                                    endDate: snapshot.data.documents[index]['endDate'],
                                    endTime: snapshot.data.documents[index]['endDate'],
                                    issue: snapshot.data.documents[index]['issue'],
                                    lineNo: snapshot.data.documents[index]['lineNo'],
                                    machineNo: snapshot.data.documents[index]['machineNo'],
                                    raisedBy: snapshot.data.documents[index]['raisedBy'],
                                    startDate: snapshot.data.documents[index]['startDate'],
                                    startTime: snapshot.data.documents[index]['startTime'],
                                    status: snapshot.data.documents[index]['status'],
                                    raisedByUid: snapshot.data.documents[index]['raisedByUid'],
                                    typeofIssue: snapshot.data.documents[index]['typeofIssue'],
                                    verifiedDate: snapshot.data.documents[index]['verifiedDate'],
                                    verifiedTime: snapshot.data.documents[index]['verifiedTime'],
                                  ),
                                ) : Container();
                              },
                        );
                      })),
            ),
          ],
        ),
      ),
    );
  }
}