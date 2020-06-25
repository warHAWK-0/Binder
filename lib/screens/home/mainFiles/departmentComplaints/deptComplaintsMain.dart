import 'dart:async';

import 'package:Binder/models/complaint.dart';
import 'package:Binder/models/user_data.dart';
import 'package:Binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:Binder/shared/CustomAppBar.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class deptComplaints extends StatefulWidget {
  final UserDetails userDetails;

  const deptComplaints({Key key, this.userDetails}) : super(key: key);

  @override
  _deptComplaintsState createState() => _deptComplaintsState();
}

class _deptComplaintsState extends State<deptComplaints> {
  bool loading = false;
  bool hasComplaint = false;
  StreamController<List<DocumentSnapshot>> _streamController =
  StreamController<List<DocumentSnapshot>>();
  List<DocumentSnapshot> deptComplaints = [];
  bool _isRequesting = false;
  bool _isFinish = false;
  @override
  void initState() {
    Firestore.instance
        .collection('departmentComplaints')
        .orderBy('startDate', descending: true)
        .snapshots()
        .listen((data) => onChangeData(data.documentChanges));
    requestNextPage();
    super.initState();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void onChangeData(List<DocumentChange> documentChanges) {
    var isChange = false;
    documentChanges.forEach((productChange) {
      if (productChange.type == DocumentChangeType.removed) {
        deptComplaints.removeWhere((product) {
          return productChange.document.documentID == product.documentID;
        });
        isChange = true;
      } else {
        if (productChange.type == DocumentChangeType.modified) {
          int indexWhere = deptComplaints.indexWhere((product) {
            return productChange.document.documentID == product.documentID;
          });

          if (indexWhere >= 0) {
            deptComplaints[indexWhere] = productChange.document;
          }
          isChange = true;
        }
      }
    });

    if (isChange) {
      _streamController.add(deptComplaints);
    }
  }

  void requestNextPage() async {
    if (!_isRequesting && !_isFinish) {
      QuerySnapshot querySnapshot;
      _isRequesting = true;
      if (deptComplaints.isEmpty) {
        querySnapshot = await Firestore.instance
            .collection('departmentComplaints')
            .orderBy('startDate', descending: true)
            .limit(7)
            .getDocuments();
      } else {
        querySnapshot = await Firestore.instance
            .collection('departmentComplaints')
            .orderBy('startDate', descending: true)
            .startAfterDocument(deptComplaints[deptComplaints.length - 1])
            .limit(7)
            .getDocuments();
      }

      if (querySnapshot != null) {
        int oldSize = deptComplaints.length;
        deptComplaints.addAll(querySnapshot.documents);
        int newSize = deptComplaints.length;
        if (oldSize != newSize) {
          _streamController.add(deptComplaints);
        } else {
          _isFinish = true;
        }
      }
      _isRequesting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          backIcon: false,
          child: Text(
            'Department Complaints',
            style: titleText,
          )),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.maxScrollExtent == scrollInfo.metrics.pixels) {
            requestNextPage();
          }
          return true;
        },
        child: Stack(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 25),
                child: StreamBuilder<List<DocumentSnapshot>>(
                    stream: _streamController.stream,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
                      return !snapshot.hasData
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height:
                            MediaQuery.of(context).size.height / 25,
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
                        itemCount: snapshot.data.length,
                        itemBuilder: (_, index) {
                          return snapshot.data[index]['status'] !=
                              "finsished"
                              ? CustomComplaintCard(
                            userDetails: widget.userDetails,
                            complaint: Complaint(
                              complaintId:
                              snapshot.data[index].documentID,
                              assignedDate: snapshot.data[index]
                              ['assignedDate'],
                              assignedTime: snapshot.data[index]
                              ['assignedTime'],
                              assignedTo: snapshot.data[index]
                              ['assignedTo'],
                              assignedToUid: snapshot.data[index]
                              ['assignedToUid'],
                              assignedBy: snapshot.data[index]
                              ['assignedBy'],
                              mobileNo: snapshot.data[index]
                              ['mobileNo'],
                              department: snapshot.data[index]
                              ['department'],
                              endDate: snapshot.data[index]
                              ['endDate'],
                              endTime: snapshot.data[index]
                              ['endDate'],
                              issue: snapshot.data[index]['issue'],
                              lineNo: snapshot.data[index]
                              ['lineNo'],
                              machineNo: snapshot.data[index]
                              ['machineNo'],
                              raisedBy: snapshot.data[index]
                              ['raisedBy'],
                              startDate: snapshot.data[index]
                              ['startDate'],
                              startTime: snapshot.data[index]
                              ['startTime'],
                              status: snapshot.data[index]
                              ['status'],
                              raisedByUid: snapshot.data[index]
                              ['raisedByUid'],
                              typeofIssue: snapshot.data[index]
                              ['typeofIssue'],
                              verifiedDate: snapshot.data[index]
                              ['verifiedDate'],
                              verifiedTime: snapshot.data[index]
                              ['verifiedTime'],
                            ),
                          )
                              : Container();
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
