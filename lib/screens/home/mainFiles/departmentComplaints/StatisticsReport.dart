import 'package:Binder/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Binder/shared/CustomAppBar.dart';
import 'package:Binder/shared/themes.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:Binder/models/user_data.dart';


class StatisticsReport extends StatefulWidget {
  final UserDetails userDetails;
  const StatisticsReport({Key key, this.userDetails}) : super(key: key);
  @override
  _StatisticsReportState createState() => _StatisticsReportState();
}

class _StatisticsReportState extends State<StatisticsReport> {
  final _formkey = GlobalKey<FormState>();
  String filePath;
  Future<String> get _localPath async {
    final directory = await getExternalStorageDirectory();
    return directory.absolute.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    setState(() {
      filePath = '$path/completedReport${selectedData1.toString().substring(0,11)}_${selectedData2.toString().substring(0,11)}.csv';
    });

    print(filePath);
    return File('$filePath').create();
  }

  generateComplaints() async {
    //completedComplaints consists of complaints that are resolved
    //For trial you can replace with 'departmentComplaints'
    //date format :-Its hardcoded should replace it with variable entered by user
    final QuerySnapshot complaints = await Firestore.instance
        .collection('departmentComplaints')
        .orderBy("startDate")
        .where("startDate", isGreaterThanOrEqualTo: selectedData1.toString().substring(0,11),isLessThanOrEqualTo: selectedData2.toString().substring(0,11))
        .getDocuments();
    final List<DocumentSnapshot> docComplaints = complaints.documents;
    List<List<dynamic>> rows = List<List<dynamic>>();
    List<dynamic> fields = [
      "complaintId",
      "machineNo",
      "lineNo",
      "issue",
      "typeOfIssue",
      "raisedBy",
      "startDate",
      "startTime",
      "assignedBy",
      "assignedDate",
      "assignedTime",
      'assignedTo',
      "endDate",
      "endTime",
      "verifiedDate",
      "verifiedTime",
      "remark"
    ];
    rows.add(fields);
    for (int i = 0; i < docComplaints.length; i++) {
//row refer to each column of a row in csv file and rows refer to each row in a file
      List<dynamic> row = List();
      row.add(docComplaints[i].data["complaintId"]);
      row.add(docComplaints[i].data["machineNo"]);
      row.add(docComplaints[i].data["lineNo"]);
      row.add(docComplaints[i].data["issue"]);
      row.add(docComplaints[i].data["typeofIssue"]);
      row.add(docComplaints[i].data["raisedBy"]);
      row.add(docComplaints[i].data["startDate"]);
      row.add(docComplaints[i].data["startTime"]);
      row.add(docComplaints[i].data["assignedBy"]);
      row.add(docComplaints[i].data["assignedDate"]);
      row.add(docComplaints[i].data["assignedTime"]);
      row.add(docComplaints[i].data["assignedTo"]);
      row.add(docComplaints[i].data["endDate"]);
      row.add(docComplaints[i].data["endTime"]);
      row.add(docComplaints[i].data["verifiedDate"]);
      row.add(docComplaints[i].data["verifiedTime"]);
      row.add(docComplaints[i].data["remark"]);
      rows.add(row);
    }
    File f = await _localFile;
    String csv = const ListToCsvConverter().convert(rows);
    print("CSV FILE IS HERE FOR YOU :$csv");
    f.writeAsString(csv);

    String username = 'binderproject9@gmail.com';
    String password = 'Binder@123';
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Binder App')
      ..recipients.add(widget.userDetails.email)
      ..subject = 'Binder Report From:${selectedData1.toString().substring(0,11)} To: ${selectedData2.toString().substring(0,11)}'
      ..text="Dear ${widget.userDetails.name}, \n \n Kindly find the attached report below. \n \n\n With Regards \n Team Binder"
      ..attachments.add(FileAttachment(f));

    final sendReport = await send(message, smtpServer);
    print("sent :)");
  }

  bool isLoading = false;
  bool loading = true;
  DateTime selectedData1;
  DateTime selectedData2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        child: Text(
          'Statistics',
          style: titleText,
        ),
        elevation: false,
        backIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  DateField(
                    onDateSelected: (DateTime value) {
                      setState(() {
                        selectedData1 = value;
                        print(selectedData1);
                      });
                    },
                    label: 'From',
                    lastDate: DateTime(int.parse(DateTime.now().toString().substring(0,4)),int.parse(DateTime.now().toString().substring(5,7)),int.parse(DateTime.now().toString().substring(8,10))),

                    selectedDate: selectedData1,
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  DateField(
                    onDateSelected: (DateTime value) {
                      setState(() {
                        selectedData2 = value;
                        print(DateTime.now());
                      });
                    },
                    label: 'To',
                    firstDate: selectedData1,
                    lastDate: DateTime(int.parse(DateTime.now().toString().substring(0,4)),int.parse(DateTime.now().toString().substring(5,7)),int.parse(DateTime.now().toString().substring(8,10))),
                    selectedDate: selectedData2,
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //text

                  //submit button
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: isLoading
                        ? Loading()
                        : FlatButton(
                            color: Color(0xFF1467B3),
                            textColor: Colors.white,
                            disabledColor: Colors.grey,
                            disabledTextColor: Colors.black,
                            padding: EdgeInsets.all(8.0),
                            splashColor: Colors.blueAccent,
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              // code
                              generateComplaints();

                              setState(() {
                                isLoading = false;
                              });
                              return Alert(
                                context: context,
                                type: AlertType.success,
                                title: "CSV Generated!",
                                desc: "File stored in InternalStorage/Android/data/com.example.final_binder/files",
                                buttons: [
                                  DialogButton(
                                    child: Text(
                                      "Okay",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Color(0xFF1467B3),
                                  ),
                                ],
                              ).show();
                            },
                            child: Text(
                              "Generate Report",
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
