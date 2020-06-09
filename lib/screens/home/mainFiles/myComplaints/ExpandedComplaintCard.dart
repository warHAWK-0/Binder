import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/CustomAppBar.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';

enum ComplaintVerificationValue { solved, unsolved }

class ExpandedComplainVerify extends StatefulWidget {
  final int complaintNo;

  const ExpandedComplainVerify({Key key, @required this.complaintNo})
      : super(key: key);

  @override
  _ExpandedComplainVerifyState createState() => _ExpandedComplainVerifyState();
}

class _ExpandedComplainVerifyState extends State<ExpandedComplainVerify> {
  ComplaintVerificationValue _radioVerifyValue =
      ComplaintVerificationValue.unsolved;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          'Complaint No - ' + widget.complaintNo.toString(),
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
                Hero(
                  tag: 'Complaint-' + widget.complaintNo.toString(),
                  child: Container(
                    height: 365,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Title of complaint ",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Machine No. ",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: primaryblue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(top: 5, right: 5),
                                  child: Icon(
                                    Icons.brightness_1,
                                    color: Color(0xFFFF5656),
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
                              Text("Line No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Machine No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Issue :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Status:", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Raised by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Time :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned to :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Description :", style: detailsTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text("Date ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Spacer(),
                              Container(
                                child: Text("Department",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                            value: ComplaintVerificationValue.solved,
                            groupValue: _radioVerifyValue,
                            onChanged: (ComplaintVerificationValue value) {
                              setState(() {
                                _radioVerifyValue = value;
                              });
                            },
                          ),
                          new Text(
                            'Solved',
                            style: new TextStyle(
                                fontFamily: 'Roboto', fontSize: 16.0),
                          ),
                          new Radio(
                            value: ComplaintVerificationValue.unsolved,
                            groupValue: _radioVerifyValue,
                            onChanged: (ComplaintVerificationValue value) {
                              setState(() {
                                _radioVerifyValue = value;
                              });
                            },
                          ),
                          new Text(
                            'Not Solved',
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
                              print('');
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

enum ComplaintStatusValue { solved, ongoing, pending, transferAME }

class ExpandedComplainStatus extends StatefulWidget {
  final int complaintNo;

  const ExpandedComplainStatus({Key key, @required this.complaintNo})
      : super(key: key);

  @override
  _ExpandedComplainStatusState createState() => _ExpandedComplainStatusState();
}

class _ExpandedComplainStatusState extends State<ExpandedComplainStatus> {
  ComplaintStatusValue _radioStatusValue = ComplaintStatusValue.pending;
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          'Complaint No - ' + widget.complaintNo.toString(),
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
                Hero(
                  tag: 'Complaint-' + widget.complaintNo.toString(),
                  child: Container(
                    height: 365,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Title of complaint ",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Machine No. ",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: primaryblue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(top: 5, right: 5),
                                  child: Icon(
                                    Icons.brightness_1,
                                    color: Color(0xFFFF5656),
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
                              Text("Line No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Machine No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Issue :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Status:", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Raised by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Time :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned to :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Description :", style: detailsTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text("Date ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Spacer(),
                              Container(
                                child: Text("Department",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                                fontSize: 18,
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
                                fontFamily: 'Roboto', fontSize: 16.0),
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
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
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
                                fontFamily: 'Roboto', fontSize: 16.0),
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
                              print('');
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
  final int complaintNo;

  const ExpandedComplaintAssign({Key key, @required this.complaintNo})
      : super(key: key);

  @override
  _ExpandedComplaintAssignState createState() =>
      _ExpandedComplaintAssignState();
}

class _ExpandedComplaintAssignState extends State<ExpandedComplaintAssign> {
  TextStyle detailsTextStyle =
      TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 14);

  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  String currentName = "";
  List<String> assignedTo = [];

  List<String> suggestions = [
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
    "Mathkar Mahesh M."
  ];
  AutoCompleteTextField searchTextField;
  bool loading = true;
  List<String> assign = [];
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryblue,
      appBar: CustomAppBar(
        child: Text(
          'Complaint No - ' + widget.complaintNo.toString(),
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
                Hero(
                  tag: 'Complaint-' + widget.complaintNo.toString(),
                  child: Container(
                    height: 365,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 2.0),
                          )
                        ]),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Title of complaint ",
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: primaryblue,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text("Machine No. ",
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: primaryblue,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(top: 5, right: 5),
                                  child: Icon(
                                    Icons.brightness_1,
                                    color: Color(0xFFFF5656),
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
                              Text("Line No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Machine No. :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Issue :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Status:", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Raised by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Time :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned to :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Assigned by :", style: detailsTextStyle),
                              SizedBox(height: 8),
                              Text("Description :", style: detailsTextStyle),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text("Date ",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                              Spacer(),
                              Container(
                                child: Text("Department",
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        color: primaryblue,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                              ),
                            ],
                          ),
                        ],
                      ),
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
                        child: AutoCompleteTextField<String>(
                          key: key,
                          clearOnSubmit: false,
                          suggestions: suggestions,
                          style:
                              TextStyle(color: Color(0xFF1467B3), fontSize: 14),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF1467B3))),
                              contentPadding:
                                  EdgeInsets.fromLTRB(10, 10, 10, 20),
                              hintText: "Search",
                              hintStyle: TextStyle(
                                  color: Color(0xFF1467B3), fontSize: 18)),
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
                              searchTextField.textField.controller.text = item;
                              print(item);
                              currentName = item;
                            });
                          },
                          itemBuilder: (context, item) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onDeleted: (){
                                setState(() {
                                  assign.removeAt(index);
                                });
                              },
                              deleteIconColor: Colors.grey,
                              label: Text(assign[index]),
                              onPressed: () {
                              },
                            );
                          }),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: new SizedBox(
                          //width: double.infinity,
                          child: new RaisedButton(
                            child: new Text(
                              "Assign",
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  color: Colors.white,
                                  fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                            color: Color(0xFF1467B3),
                            onPressed: () {
//                              currentName != ""
//                                  ? assignedTo.add(currentName)
//                                  : null;
//                              print(assignedTo[0]);
                              assign.add(myController.text);
                              print(assign);
                              setState(() { });
                            },
                          ),
                        ),
                      ),
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
