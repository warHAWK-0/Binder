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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
        //backgroundColor: Color(0xFFE5E5E5),
        appBar: CustomAppBar(
            backIcon: false,
            child: Text(
              'My Complaints',
              style: titleText,
            )),
        body: Stack(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 25),
                child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection("departmentComplaints").orderBy('startDate', descending: false)
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
          ],
        ),
      ),
    );
  }
}