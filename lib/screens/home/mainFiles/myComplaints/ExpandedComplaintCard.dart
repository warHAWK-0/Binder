import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../../shared/CustomAppBar.dart';
import '../../../../shared/themes.dart';

enum ComplaintVerificationValue { finish, notfinished }

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
      ComplaintVerificationValue.notfinished;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14);

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
                                                          "transferAME"
                                                      ? complaintStatusAME
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
                            Text(
                              "Mobile Number : ${widget.complaint.mobileNo}",
                              style: detailsTextStyle,
                            ),
                            SizedBox(height: 8),
                            Text("Line Number :${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by :${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time :${widget.complaint.startDate}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to :${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by :${widget.complaint.assignedBy}",
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
                                  onPressed: () {
                                    if (_radioVerifyValue ==
                                        ComplaintVerificationValue
                                            .notfinished) {
                                      try {
                                        dbt = DateTime.now().toString();
                                        databaseReference
                                            .collection('binder')
                                            .document(widget.userDetails.uid)
                                            .collection('complaint')
                                            .document(
                                                widget.complaint.complaintId)
                                            .updateData({
                                          'status': "raised",
                                        });
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    } else if (_radioVerifyValue ==
                                        ComplaintVerificationValue.finish) {
                                      try {
                                        dbt = DateTime.now().toString();
                                        databaseReference
                                            .collection('binder')
                                            .document(widget.userDetails.uid)
                                            .collection('complaint')
                                            .document(
                                                widget.complaint.complaintId)
                                            .updateData({
                                          'endDate': dbt.substring(0, 10),
                                          'endTime': dbt.substring(11, 16),
                                          'status': _radioVerifyValue,
                                        });
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    }
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
                                          },
                                          color: Color(0xFF1467B3),
                                        ),
                                      ],
                                    ).show();
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
                    : Container(),
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

enum ComplaintStatusValue { solved, ongoing, pending, transferAME }

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
  ComplaintStatusValue _radioStatusValue = ComplaintStatusValue.pending;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15);
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
                //tag: 'Complaint-' + widget.complaintNo.toString(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          color: Colors.grey,
//                          offset: Offset(0.0, 2.0),
//                        )
                      ]),
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
                                                          "transferAME"
                                                      ? complaintStatusAME
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
                            Text(
                              "Personal No. :",
                              style: detailsTextStyle,
                            ),
                            SizedBox(height: 8),
                            Text("Line No. :${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Status:${widget.complaint.status}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by :${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time :${widget.complaint.startDate}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to :${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by :${widget.complaint.assignedBy}",
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
                Container(
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
                            value: ComplaintStatusValue.transferAME,
                            groupValue: _radioStatusValue,
                            onChanged: (ComplaintStatusValue value) {
                              setState(() {
                                _radioStatusValue = value;
                              });
                            },
                          ),
                          new Text(
                            'Transfer to AME',
                            style: new TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.0,
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
                              "Update",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            color: Color(0xFF1467B3),
                            onPressed: () {
                              try {
                                dbt = DateTime.now().toString();
                                databaseReference
                                    .collection('binder')
                                    .document(widget.userDetails.uid)
                                    .collection('complaint')
                                    .document(widget.complaint.complaintId)
                                    .updateData({
                                  'verifiedDate': dbt.substring(0, 10),
                                  'verifiedTime': dbt.substring(11, 16),
                                  'status': _radioStatusValue
                                });
                              } catch (e) {
                                print(e.toString());
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
  List<String> nameSuggestions = [
    "Bhusnur Dattatray Prakash",
    "Jagdale Rajan Yadav",
    "Sargar Ramchandra Sopan",
    "Kachare Bharat Sampati",
    "Dixit Sharad Rajaram",
    "Awale Vishwanth Bhairu",
    "Gokule Suresh Devram",
    "Kandelkar Narayan Tukaram",
    "Kawade Chandrakant Ekanath",
    "Shinde Ajit Dashrath",
    "Jamdade Ravindra Anantrao",
    "Shendkar Vijay Mhaskoo",
    "Malusare Atmaram Krishna",
    "Lanke Kiran S.",
    "Kotasthane Kedar k.",
    "Mathkar Mahesh M.",
    "mainop"
  ];

  AutoCompleteTextField searchTextField;
  bool loading = true;
  List<String> assign = [];
  final myController = TextEditingController();

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
                //tag: 'Complaint-' + widget.complaintNo,
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: <BoxShadow>[
//                        BoxShadow(
//                          //color: Colors.grey,
//                          offset: Offset(0.0, 2.0),
//                        )
                      ]),
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
                                                          "transferAME"
                                                      ? complaintStatusAME
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
                            Text(
                              "Personal No. :",
                              style: detailsTextStyle,
                            ),
                            SizedBox(height: 8),
                            Text("Line No. :${widget.complaint.lineNo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Status:${widget.complaint.status}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Raised by :${widget.complaint.raisedBy}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Time :${widget.complaint.startDate}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned to :${widget.complaint.assignedTo}",
                                style: detailsTextStyle),
                            SizedBox(height: 8),
                            Text("Assigned by :${widget.complaint.assignedBy}",
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
                Card(
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
                                suggestions: nameSuggestions,
                                style: TextStyle(
                                    color: Color(0xFF1467B3), fontSize: 14),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                      color: Colors.white,
                                    )),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Search here",
                                    hintStyle: TextStyle(
                                        color: Color(0xFF1467B3),
                                        fontSize: 18)),
                                itemFilter: (item, query) {
                                  return item
                                      .toLowerCase()
                                      .startsWith(query.toLowerCase());
                                },
                                itemSorter: (a, b) {
                                  return a.compareTo(b);
                                },
                                itemSubmitted: (item) {
                                  setState(() {
                                    searchTextField.textField.controller.text =
                                        item;
                                    print(item);
                                    currentName = item;
                                  });
                                },
                                itemBuilder: (context, item) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        item,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontFamily: "Roboto"),
                                      ),
                                    ],
                                  );
                                },
                                controller: myController,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    assign.add(myController.text);
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
                          children:
                              List<Widget>.generate(assign.length, (int index) {
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
                                dbt = DateTime.now().toString();
                                for (var i = 0; i < assign.length; i++) {
                                  print(i);
                                  final QuerySnapshot result = await Firestore
                                      .instance
                                      .collection('binder')
                                      .getDocuments();
                                  final List<DocumentSnapshot> users =
                                      result.documents;
                                  for (DocumentSnapshot user in users) {
                                    print(user.documentID + " = ");
                                    final QuerySnapshot result2 =
                                        await Firestore.instance
                                            .collection('binder')
                                            .document(user.documentID)
                                            .collection('user_details')
                                            .getDocuments();
                                    final List<DocumentSnapshot> details =
                                        result2.documents;
                                    print(details[0].data["name"]);
                                    if (details[0].data["name"] == assign[i]) {
                                      await Firestore.instance
                                          .collection("binder")
                                          .document(user.documentID)
                                          .collection("complaint_assigned")
                                          .add({
                                        'machineNo': widget.complaint.machineNo,
                                        'department': "production",
                                        'issue': widget.complaint.issue,
                                        'lineNo': widget.complaint.lineNo,
                                        'startDate': widget.complaint.startDate,
                                        'startTime': widget.complaint.startTime,
                                        'assignedBy': widget.userDetails.name,
                                        'assignedDate': dbt.substring(0, 10),
                                        'assignedTime': dbt.substring(11, 16),
                                        'endDate': '',
                                        'endTime': '',
                                        'verifiedDate': '',
                                        'verifiedTime': '',
                                        'assignedTo': assign,
                                        'raisedBy': widget.complaint.raisedBy,
                                        'status': 'notsolved'
                                      });
                                      Alert(
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
                                    }
//
                                  }
                                }

                                databaseReference
                                    .collection('binder')
                                    .document(widget.userDetails.uid)
                                    .collection('complaint')
                                    .document(widget.complaint.complaintId)
                                    .updateData({
                                  'assignedDate': dbt.substring(0, 10),
                                  'assignedTime': dbt.substring(11, 16),
                                  'assignedTo': assign,
                                  'assignedBy': widget.userDetails.name,
                                });
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 12,
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

extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toUpperCase();
}
