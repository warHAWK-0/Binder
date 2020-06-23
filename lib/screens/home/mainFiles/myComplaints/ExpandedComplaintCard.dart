import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../shared/CustomAppBar.dart';
import '../../../../shared/themes.dart';
import '../../../../shared/themes.dart';

enum ComplaintVerificationValue { finish, notfinished , nothing }
List<String> verificationEmails = []; 

class ExpandedComplainVerify extends StatefulWidget {
  final Complaint complaint;
  final UserDetails userDetails;

  const ExpandedComplainVerify({
    Key key,
    @required this.userDetails,
    @required this.complaint,
  }) : super(key: key);

  @override
  _ExpandedComplainVerifyState createState() => _ExpandedComplainVerifyState();
}

class _ExpandedComplainVerifyState extends State<ExpandedComplainVerify> {
  final databaseReference = Firestore.instance;
  String dbt;
  ComplaintVerificationValue _radioVerifyValue =
      ComplaintVerificationValue.nothing;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14);

  // EMAIL NOTIFICATION
  sendRaiseEmail(String complaintId, String machineNo, String lineNo, String raisedBy, String time, List assignedTo, String assignedBy) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("user_details").getDocuments();
    verificationEmails.clear();
    for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
      DocumentSnapshot docsnap = await Firestore.instance
          .collection("user_details")
          .document(documentSnapshot.documentID.toString())
          .collection(documentSnapshot.documentID.toString())
          .document(documentSnapshot.documentID.toString())
          .get();
      if (docsnap.data['department'] == "production" || (docsnap.data['department'] == "maintenance" && docsnap.data['authLevel'] == "1")) {
        verificationEmails.add(docsnap.data['email']);
      }
    }
    String username = 'binderproject9@gmail.com';
    String password = 'Binder@123';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Binder App')
      ..recipients.addAll(verificationEmails)
      ..subject = 'Complaint completion verified at $time'
      ..text = 'COMPLAINT VERIFIED\n\nThe following complaint has been verified:\n\nComplaint No : $complaintId\nMachine No : $machineNo\nLine No : $lineNo\nType of issue : \nStatus : Finished\nRaised by : $raisedBy\nTime : $time\nAssigned to : $assignedTo\nAssigned by : $assignedBy\n\n\nRegards\nTeam Binder';
  final sendReport = await send(message, smtpServer);
  print('Message sent: ' + sendReport.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          widget.complaint.issue,
          style: titleText,
        ),
        backIcon: true,
        elevation: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                  "Machine Number : " +
                                      "${widget.complaint.machineNo} ",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(top: 5, right: 5),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: widget.complaint.status == "solved"
                                      ? complaintStatusSolved
                                      : widget.complaint.status == "ongoing"
                                          ? complaintStatusOngoing
                                          : widget.complaint.status == "pending"
                                              ? complaintStatusPending
                                              : widget.complaint.status ==
                                                      "notsolved"
                                                  ? complaintStatusNotSolved
                                                  : widget.complaint.status ==
                                                          "cannotBeResolved"
                                                      ? complaintStatusCannotBeResolved
                                                      : widget.complaint
                                                                  .status ==
                                                              "raised"
                                                          ? Colors.red
                                                          : Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8),
                            Text("Line Number : ${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Status : ${widget.complaint.status}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by : ${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time : ${widget.complaint.startTime}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to : ${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by : ${widget.complaint.assignedBy}",
                                style: detailsTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text("Date: ${widget.complaint.startDate}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                  "Department: ${widget.complaint.department.inCaps}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                widget.complaint.status == "solved"
                    ? Container(
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 2.0),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.topLeft,
                              child: Text("Verify",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: <Widget>[
                                new Radio(
                                  value: ComplaintVerificationValue.finish,
                                  groupValue: _radioVerifyValue,
                                  onChanged:
                                      (ComplaintVerificationValue value) {
                                    setState(() {
                                      _radioVerifyValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Finished',
                                  style: new TextStyle(
                                      fontFamily: 'Roboto', fontSize: 16.0),
                                ),
                                new Radio(
                                  value: ComplaintVerificationValue.notfinished,
                                  groupValue: _radioVerifyValue,
                                  onChanged:
                                      (ComplaintVerificationValue value) {
                                    setState(() {
                                      _radioVerifyValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Not Finished',
                                  style: new TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              //padding:EdgeInsets.only(top: 400,left:20,right: 20) ,
                              child: new SizedBox(
                                //width: double.infinity,
                                child: new RaisedButton(
                                  child: new Text(
                                    "Verify",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: Colors.white,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ),
                                  color: Color(0xFF1467B3),
                                  onPressed: () async{
                                    try{
                                      if (_radioVerifyValue ==
                                          ComplaintVerificationValue
                                              .notfinished) {
                                        for (dynamic i in widget.complaint.assignedToUid) {
                                          databaseReference
                                              .collection("binder")
                                              .document(i)
                                              .collection("complaint_assigned")
                                              .document(
                                              widget.complaint.complaintId)
                                              .delete();
                                        }

                                        databaseReference
                                            .collection('binder')
                                            .document(widget.complaint.raisedByUid)
                                            .collection('complaint')
                                            .document(widget.complaint.complaintId)
                                            .updateData({
                                              'assignedTo': null,
                                              'assignedBy': "",
                                              'assignedDate': "",
                                              'assignedTime': "",
                                              'verifyDate': "",
                                              'verifyTime': "",
                                              'assignedToUid': null,
                                              'status': "raised",
                                            });
                                      } else if (_radioVerifyValue ==
                                          ComplaintVerificationValue.finish) {
                                        dbt = DateTime.now().toString();
                                        for (dynamic i in widget.complaint.assignedToUid) {
                                          databaseReference
                                              .collection("binder")
                                              .document(i)
                                              .collection("complaint_assigned")
                                              .document(
                                              widget.complaint.complaintId)
                                              .delete();
                                        }

                                        databaseReference
                                            .collection('binder')
                                            .document(widget.userDetails.uid)
                                            .collection('complaint')
                                            .document(widget.complaint.complaintId)
                                            .updateData({
                                              'endDate': dbt.substring(0, 10),
                                              'endTime': dbt.substring(11, 16),
                                              'status': _radioVerifyValue,
                                            });
                                      }

                                      sendRaiseEmail(widget.complaint.complaintId,widget.complaint.machineNo,widget.complaint.lineNo,widget.complaint.raisedBy,dbt.substring(11, 16),widget.complaint.assignedTo,widget.userDetails.name);

                                      return Alert(
                                        context: context,
                                        type: AlertType.success,
                                        title: "Complaint verified!",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Okay",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            color: Color(0xFF1467B3),
                                          ),
                                        ],
                                      ).show();
                                    }catch(e){
                                      return Alert(
                                        context: context,
                                        type: AlertType.error,
                                        title: "Error!",
                                        buttons: [
                                          DialogButton(
                                            child: Text(
                                              "Okay",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: Color(0xFF1467B3),
                                          ),
                                        ],
                                      ).show();
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Icon(
                              Icons.warning,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Please wait while maintenance department takes further action.',
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer()
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
* =========================================================================================================
* */

enum ComplaintStatusValue {
  solved,
  ongoing,
  pending,
  cannotBeResolved,
  nothing
}

List<String> stausChangeEmails = []; 

class ExpandedComplainStatus extends StatefulWidget {
  final Complaint complaint;
  final UserDetails userDetails;

  const ExpandedComplainStatus(
      {Key key, @required this.userDetails, @required this.complaint})
      : super(key: key);

  @override
  _ExpandedComplainStatusState createState() => _ExpandedComplainStatusState();
}

class _ExpandedComplainStatusState extends State<ExpandedComplainStatus> {
  final databaseReference = Firestore.instance;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15);

  ComplaintStatusValue _radioStatusValue = ComplaintStatusValue.nothing;

  ComplaintStatusValue getValue() {
    return widget.complaint.status == "solved"
        ? ComplaintStatusValue.solved
        : widget.complaint.status == "ongoing"
            ? ComplaintStatusValue.ongoing
            : widget.complaint.status == "pending"
                ? ComplaintStatusValue.pending
                : widget.complaint.status == "cannotBeResolved"
                    ? ComplaintStatusValue.cannotBeResolved
                    : ComplaintStatusValue.ongoing;
  }

  // EMAIL NOTIFICATION
  sendStatusChangeEmail(String complaintId, String machineNo, String lineNo, String status,String raisedBy, String time, List assignedTo, String assignedBy) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("user_details").getDocuments();
    stausChangeEmails.clear();
    for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
      DocumentSnapshot docsnap = await Firestore.instance
          .collection("user_details")
          .document(documentSnapshot.documentID.toString())
          .collection(documentSnapshot.documentID.toString())
          .document(documentSnapshot.documentID.toString())
          .get();
      if (docsnap.data['authLevel'] == "1") {
        stausChangeEmails.add(docsnap.data['email']);
      }
    }
    String username = 'binderproject9@gmail.com';
    String password = 'Binder@123';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Binder App')
      ..recipients.addAll(stausChangeEmails)
      ..subject = 'Complaint status changed at $time'
      ..text = 'COMPLAINT STATUS UPDATED\n\nThe following complaint status has been updated:\n\nComplaint No : $complaintId\nMachine No : $machineNo\nLine No : $lineNo\nType of issue : \nStatus : $status\nRaised by : $raisedBy\nTime : $time\nAssigned to : $assignedTo\nAssigned by : $assignedBy\n\n\nRegards\nTeam Binder';
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          widget.complaint.issue,
          style: titleText,
        ),
        backIcon: true,
        elevation: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                  "Machine Number : " +
                                      "${widget.complaint.machineNo} ",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(top: 5, right: 5),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: widget.complaint.status == "solved"
                                      ? complaintStatusSolved
                                      : widget.complaint.status == "ongoing"
                                          ? complaintStatusOngoing
                                          : widget.complaint.status == "pending"
                                              ? complaintStatusPending
                                              : widget.complaint.status ==
                                                      "notsolved"
                                                  ? complaintStatusNotSolved
                                                  : widget.complaint.status ==
                                                          "cannotBeResolved"
                                                      ? complaintStatusCannotBeResolved
                                                      : widget.complaint
                                                                  .status ==
                                                              "raised"
                                                          ? Colors.red
                                                          : Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8),
                            Text("Line Number : ${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Status : ${widget.complaint.status}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by : ${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time : ${widget.complaint.startTime}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to : ${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by : ${widget.complaint.assignedBy}",
                                style: detailsTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text("Date :${widget.complaint.startDate}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                  "Department :${widget.complaint.department}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                widget.complaint.status == "cannotBeSolved" ||
                        widget.complaint.status == "solved"
                    ? Container(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Icon(
                              Icons.warning,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'You have forwarded the complaint for verification.',
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer()
                          ],
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 2.0),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              alignment: Alignment.topLeft,
                              child: Text("Update Status",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: <Widget>[
                                new Radio(
                                  value: ComplaintStatusValue.solved,
                                  groupValue: _radioStatusValue,
                                  onChanged: (ComplaintStatusValue value) {
                                    setState(() {
                                      _radioStatusValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Solved',
                                  style: new TextStyle(
                                      fontFamily: 'Roboto', fontSize: 14.0),
                                ),
                                new Radio(
                                  value: ComplaintStatusValue.ongoing,
                                  groupValue: _radioStatusValue,
                                  onChanged: (ComplaintStatusValue value) {
                                    setState(() {
                                      _radioStatusValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Ongoing',
                                  style: new TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                new Radio(
                                  value: ComplaintStatusValue.pending,
                                  groupValue: _radioStatusValue,
                                  onChanged: (ComplaintStatusValue value) {
                                    setState(() {
                                      _radioStatusValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Pending',
                                  style: new TextStyle(
                                      fontFamily: 'Roboto', fontSize: 14.0),
                                ),
                                new Radio(
                                  value: ComplaintStatusValue.cannotBeResolved,
                                  groupValue: _radioStatusValue,
                                  onChanged: (ComplaintStatusValue value) {
                                    setState(() {
                                      _radioStatusValue = value;
                                    });
                                  },
                                ),
                                new Text(
                                  'Cannot Be Resolved',
                                  style: new TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  //padding:EdgeInsets.only(top: 400,left:20,right: 20) ,
                                  child: new SizedBox(
                                    //width: double.infinity,
                                    child: new RaisedButton(
                                      child: new Text(
                                        "Update",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: Color(0xFF1467B3),
                                      onPressed: () async{
                                        try {
                                          for (dynamic i in widget
                                              .complaint.assignedToUid) {
                                            databaseReference
                                                .collection('binder')
                                                .document(i)
                                                .collection(
                                                    'complaint_assigned')
                                                .document(widget
                                                    .complaint.complaintId)
                                                .updateData({
                                              'verifiedDate': DateTime.now()
                                                  .toString()
                                                  .substring(0, 10),
                                              'verifiedTime': DateTime.now()
                                                  .toString()
                                                  .substring(11, 16),
                                              'status': _radioStatusValue ==
                                                      ComplaintStatusValue
                                                          .solved
                                                  ? "solved"
                                                  : _radioStatusValue ==
                                                          ComplaintStatusValue
                                                              .ongoing
                                                      ? "ongoing"
                                                      : _radioStatusValue ==
                                                              ComplaintStatusValue
                                                                  .pending
                                                          ? "pending"
                                                          : _radioStatusValue ==
                                                                  ComplaintStatusValue
                                                                      .cannotBeResolved
                                                              ? "cannotBeResolved"
                                                              : "ongoing",
                                            });
                                          }
                                          databaseReference
                                              .collection('binder')
                                              .document(
                                                  widget.complaint.raisedByUid)
                                              .collection('complaint')
                                              .document(
                                                  widget.complaint.complaintId)
                                              .updateData({
                                            'verifiedDate': DateTime.now()
                                                .toString()
                                                .substring(0, 10),
                                            'verifiedTime': DateTime.now()
                                                .toString()
                                                .substring(11, 16),
                                            'status': _radioStatusValue ==
                                                    ComplaintStatusValue.solved
                                                ? "solved"
                                                : _radioStatusValue ==
                                                        ComplaintStatusValue
                                                            .ongoing
                                                    ? "ongoing"
                                                    : _radioStatusValue ==
                                                            ComplaintStatusValue
                                                                .pending
                                                        ? "pending"
                                                        : _radioStatusValue ==
                                                                ComplaintStatusValue
                                                                    .cannotBeResolved
                                                            ? "cannotBeResolved"
                                                            : "ongoing"
                                          });

                                          sendStatusChangeEmail(widget.complaint.complaintId,widget.complaint.machineNo,widget.complaint.lineNo,widget.complaint.status,widget.complaint.raisedBy,DateTime.now().toString().substring(11, 16),widget.complaint.assignedTo,widget.userDetails.name);

                                          return Alert(
                                            context: context,
                                            type: AlertType.success,
                                            title: "Status Updated!",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Okay",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                color: Color(0xFF1467B3),
                                              ),
                                            ],
                                          ).show();
                                        } catch (e) {
                                          return Alert(
                                            context: context,
                                            type: AlertType.error,
                                            title: "Error!",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Okay",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Color(0xFF1467B3),
                                              ),
                                            ],
                                          ).show();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
* =========================================================================================================
* */
class ExpandedComplaintAssign extends StatefulWidget {
  final Complaint complaint;
  final UserDetails userDetails;

  const ExpandedComplaintAssign(
      {Key key, @required this.userDetails, @required this.complaint})
      : super(key: key);

  @override
  _ExpandedComplaintAssignState createState() =>
      _ExpandedComplaintAssignState();
}

class _ExpandedComplaintAssignState extends State<ExpandedComplaintAssign> {
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15);
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String currentName = "";
  List<String> assignedTo = [];
  final databaseReference = Firestore.instance;
  List<String> uids = [];
  List<Map<String, String>> selectedUid = [];
  List<String> names = [];
  List<String> assignedToUid = [];
  AutoCompleteTextField searchTextField;
  bool loading = true;
  List<String> assign = [];
  final myController = TextEditingController();
  List<String> assignEmails = [];

  Future getNamesOfAllOperators(String typeOfIssue) async {
    try {
      QuerySnapshot querySnapshot =
          await Firestore.instance.collection("binder").getDocuments();
      typeOfIssue == "Mechanical Issue"
          ? typeOfIssue = "Mechanical"
          // ignore: unnecessary_statements
          : typeOfIssue == "Electrical Issue" ? typeOfIssue = "Electrical" : "";
      names.clear();
      uids.clear();
      for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
        DocumentSnapshot docsnap = await Firestore.instance
            .collection("binder")
            .document(documentSnapshot.documentID.toString())
            .collection("user_details")
            .document(documentSnapshot.documentID.toString())
            .get();
        if (docsnap.data['typeOfOperator'] == typeOfIssue) {
          names.add(docsnap.data['name']);
          uids.add(docsnap.data['uid']);
        }
      }
    } catch (e) {}
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,
        () => getNamesOfAllOperators(widget.complaint.typeofIssue));
  }

  // EMAIL NOTIFICATION
  sendAssignEmail(List assignedToUid,String complaintId, String machineNo, String lineNo, String status,String raisedBy, String time, List assignedTo, String assignedBy) async {
    QuerySnapshot querySnapshot = await Firestore.instance.collection("user_details").getDocuments();
    assignEmails.clear();
    for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
      DocumentSnapshot docsnap = await Firestore.instance
          .collection("user_details")
          .document(documentSnapshot.documentID.toString())
          .collection(documentSnapshot.documentID.toString())
          .document(documentSnapshot.documentID.toString())
          .get();
      if ((docsnap.data['department'] == "production" && docsnap.data['authLevel'] == "1") ||
          (docsnap.data['department'] == "maintenance" && docsnap.data['authLevel'] == "0")) {
            for(var i=0;i<assignedToUid.length;i++){
              if(docsnap.data['uid'] == assignedToUid[i])
              {
                assignEmails.add(docsnap.data['email']);
              }
            }
      }
    }
    String username = 'binderproject9@gmail.com';
    String password = 'Binder@123';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Binder App')
      ..recipients.addAll(assignEmails)
      ..subject = 'Complaint assigned at $time'
      ..text = 'COMPLAINT ASSIGNED\n\nYou have been assigned the following complaint :\n\nComplaint No : $complaintId\nMachine No : $machineNo\nLine No : $lineNo\nType of issue : \nStatus : $status\nRaised by : $raisedBy\nTime : $time\nAssigned to : $assignedTo\nAssigned by : $assignedBy\n\n\nRegards\nTeam Binder';
    final sendReport = await send(message, smtpServer);
    print('Message sent: ' + sendReport.toString());
    }

  String dbt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          widget.complaint.issue,
          style: titleText,
        ),
        backIcon: true,
        elevation: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[]),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                  "Machine Number : " +
                                      "${widget.complaint.machineNo} ",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Spacer(),
                            Container(
                                margin: EdgeInsets.only(top: 5, right: 5),
                                child: Icon(
                                  Icons.brightness_1,
                                  color: widget.complaint.status == "solved"
                                      ? complaintStatusSolved
                                      : widget.complaint.status == "ongoing"
                                          ? complaintStatusOngoing
                                          : widget.complaint.status == "pending"
                                              ? complaintStatusPending
                                              : widget.complaint.status ==
                                                      "notsolved"
                                                  ? complaintStatusNotSolved
                                                  : widget.complaint.status ==
                                                          "cannotBeResolved"
                                                      ? complaintStatusCannotBeResolved
                                                      : widget.complaint
                                                                  .status ==
                                                              "raised"
                                                          ? Colors.red
                                                          : Colors.black,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 8),
                            Text("Line Number : ${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Status : ${widget.complaint.status}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by : ${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time : ${widget.complaint.startTime}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to : ${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by : ${widget.complaint.assignedBy}",
                                style: detailsTextStyle),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              child: Text(
                                  "Date : ${widget.complaint.startDate}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                  "Department : ${widget.complaint.department.substring(0, 1).toUpperCase() + widget.complaint.department.substring(1, widget.complaint.department.length).toLowerCase()}",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                widget.complaint.status == "raised"
                    ? loading == false
                        ? Card(
                            //margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(top: 20, left: 20),
                                  child: Text("Assign Operator",
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: Color(0xFF1467B3),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 8,
                                        child: AutoCompleteTextField<String>(
                                          key: key,
                                          clearOnSubmit: false,
                                          suggestions: names,
                                          style: TextStyle(
                                              color: Color(0xFF1467B3),
                                              fontSize: 14),
                                          decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                color: Colors.white,
                                              )),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              hintText: "Search here",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF1467B3),
                                                  fontSize: 18)),
                                          itemFilter: (item, query) {
                                            return item
                                                .toLowerCase()
                                                .startsWith(
                                                    query.toLowerCase());
                                          },
                                          itemSorter: (a, b) {
                                            return a.compareTo(b);
                                          },
                                          itemSubmitted: (item) {
                                            setState(() {
                                              currentName = item;
                                              searchTextField.controller.text =
                                                  item;
                                            });
                                          },
                                          itemBuilder: (context, item) {
                                            return Container(
                                              padding: EdgeInsets.all(8),
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black,
                                                    fontFamily: "Roboto"),
                                              ),
                                            );
                                          },
                                          controller: myController,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              assign.add(myController.text);
                                              assignedToUid.add(uids[names
                                                      .indexWhere((element) =>
                                                          element.contains(
                                                              myController
                                                                  .text))]
                                                  .toString());
                                            });
                                            myController.clear();
                                          },
                                          child: Container(
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  alignment: Alignment.topLeft,
                                  margin: EdgeInsets.only(left: 20),
                                  child: Wrap(
                                    spacing: 6.0,
                                    //runSpacing: 6.0,
                                    children: List<Widget>.generate(
                                        assign.length, (int index) {
                                      return InputChip(
                                        avatar: CircleAvatar(
                                          backgroundColor: Color(0xFF1467B3),
                                          child: Text(assign[index][0]),
                                        ),
                                        deleteIcon: Icon(Icons.cancel),
                                        onDeleted: () {
                                          setState(() {
                                            assign.removeAt(index);
                                          });
                                        },
                                        deleteIconColor: Colors.grey,
                                        label: Text(assign[index]),
                                        onPressed: () {},
                                      );
                                    }),
                                  ),
                                ),
                                SizedBox(
                                  height: 3.5,
                                ),
                                Container(
                                  child: new SizedBox(
                                    //width: double.infinity,
                                    child: new RaisedButton(
                                      child: new Text(
                                        "Assign Now",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: Colors.white,
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: Color(0xFF1467B3),
                                      onPressed: () async {
                                        try {
                                          for (var i in assign) {
                                            String currentUid = uids[names
                                                    .indexWhere((element) =>
                                                        element.contains(i))]
                                                .toString();
                                            await Firestore.instance
                                                .collection("binder")
                                                .document(currentUid)
                                                .collection(
                                                    "complaint_assigned")
                                                .document(widget
                                                    .complaint.complaintId)
                                                .setData({
                                              'machineNo':
                                                  widget.complaint.machineNo,
                                              'department':
                                                  widget.complaint.department,
                                              'issue': widget.complaint.issue,
                                              'lineNo': widget.complaint.lineNo,
                                              'startDate':
                                                  widget.complaint.startDate,
                                              'startTime':
                                                  widget.complaint.startTime,
                                              'assignedBy':
                                                  widget.userDetails.name,
                                              'assignedDate': DateTime.now()
                                                  .toString()
                                                  .substring(0, 10),
                                              'assignedTime': DateTime.now()
                                                  .toString()
                                                  .substring(11, 16),
                                              'endDate': '',
                                              'endTime': '',
                                              'verifiedDate': '',
                                              'verifiedTime': '',
                                              'raisedByUid':
                                                  widget.complaint.raisedByUid,
                                              'assignedTo': assign,
                                              'assignedToUid': assignedToUid,
                                              'raisedBy':
                                                  widget.complaint.raisedBy,
                                              'status': 'ongoing'
                                            });
                                          }
                                          await Firestore.instance
                                              .collection('binder')
                                              .document(
                                                  widget.complaint.raisedByUid)
                                              .collection('complaint')
                                              .document(
                                                  widget.complaint.complaintId)
                                              .updateData({
                                            'status': "ongoing",
                                            'assignedDate': DateTime.now()
                                                .toString()
                                                .substring(0, 10),
                                            'assignedTime': DateTime.now()
                                                .toString()
                                                .substring(11, 16),
                                            'assignedTo': assign,
                                            'assignedToUid': assignedToUid,
                                            'assignedBy':
                                                widget.userDetails.name,
                                          });

                                          sendAssignEmail(assignedToUid,widget.complaint.complaintId,widget.complaint.machineNo,widget.complaint.lineNo,widget.complaint.status,widget.complaint.raisedBy,DateTime.now().toString().substring(11, 16),widget.complaint.assignedTo,widget.userDetails.name);

                                          return Alert(
                                            context: context,
                                            type: AlertType.success,
                                            title: "Complaint Assigned!",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Okay",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                },
                                                color: Color(0xFF1467B3),
                                              ),
                                            ],
                                          ).show();
                                        } catch (e) {
                                          return Alert(
                                            context: context,
                                            type: AlertType.error,
                                            title: "Error!",
                                            buttons: [
                                              DialogButton(
                                                child: Text(
                                                  "Okay",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Color(0xFF1467B3),
                                              ),
                                            ],
                                          ).show();
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            child: Column(
                              children: <Widget>[
                                Loading(),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  'Getting Complaint Status',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                    : Container(
                        color: Colors.white,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Spacer(),
                            Icon(
                              Icons.warning,
                              size: 20,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'This complaint has already been assigned',
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer()
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
        //),
      ),
    );
  }
}

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}
