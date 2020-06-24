import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/addcomplaint.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CustomComplaintCard.dart';

// ignore: camel_case_types
class myComplaints extends StatefulWidget {
  final UserDetails userDetails;
  const myComplaints({Key key, this.userDetails}) : super(key: key);
  @override
  _myComplaintsState createState() => _myComplaintsState();
}

// ignore: camel_case_types
class _myComplaintsState extends State<myComplaints> {

  bool hasComplaint = false;

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
                        .collection("complaint")
                        .document(widget.userDetails.department == "production" ? "complaintRaised" : "complaintAssigned")
                        .collection(widget.userDetails.uid)
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
                          : ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          return snapshot.data.documents[index]['status'] != "finsished" ? CustomComplaintCard(
                            userDetails: widget.userDetails,
                            complaint: Complaint(
                              remark: snapshot.data.documents[index]['remark'],
                              complaintId: snapshot.data.documents[index]['complaint'],
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

        floatingActionButton: (widget.userDetails.department == "production") ? FloatingActionButton(
            backgroundColor: primaryblue,
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => addComplaint(
                        userDetails: widget.userDetails,
                      )));
            }) : null,
      ),
    );
  }
}