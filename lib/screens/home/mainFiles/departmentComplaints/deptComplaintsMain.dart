import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/departmentComplaints/testCustomCompCard.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/loading.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_binder/models/myData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class maintenanceDeptComplaints extends StatefulWidget {
  final UserDetails userDetails;

  const maintenanceDeptComplaints({Key key, this.userDetails})
      : super(key: key);

  @override
  _maintenanceDeptComplaintsState createState() =>
      _maintenanceDeptComplaintsState();
}

class _maintenanceDeptComplaintsState extends State<maintenanceDeptComplaints> {
  final List<int> complaintNo = [1, 2, 3, 4, 5, 6];
  List<Complaint> allComplaintData = [];
  List<String> documentNames = [];

  Future getAllDocuments() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("binder").getDocuments();
    documentNames.clear();
    allComplaintData.clear();
    for (DocumentSnapshot documentSnapshot in querySnapshot.documents) {
      documentNames.add(documentSnapshot.documentID.toString());
      print(documentSnapshot.documentID.toString());
      QuerySnapshot querySnapshotComplaint =
          await Firestore.instance.collection("binder").document(documentSnapshot.documentID.toString())
            .collection("complaint").getDocuments();
      for(DocumentSnapshot docSnapshot in querySnapshotComplaint.documents){
        print("=>"+docSnapshot.data['issue'].toString()+"\n");
        allComplaintData.add(Complaint(
          assignedDate: docSnapshot.data['assignedDate'],
          assignedTime: docSnapshot.data['assignedTime'],
          assignedTo: docSnapshot.data['assignedTo'],
          department: docSnapshot.data['department'],
          endDate: docSnapshot.data['endDate'],
          endTime: docSnapshot.data['endTime'],
          issue: docSnapshot.data['issue'],
          lineNo: docSnapshot.data['lineNo'],
          machineNo: docSnapshot.data['machineNo'],
          raisedBy: docSnapshot.data['raisedBy'],
          startDate: docSnapshot.data['startDate'],
          startTime: docSnapshot.data['startTime'],
          status: docSnapshot.data['status'],
          verifiedDate: docSnapshot.data['verifiedDate'],
          verifiedTime: docSnapshot.data['verifiedTime'],
        ));
      }
    }
    return querySnapshot.documents;
  }

  //Unused function
  Future getAllComplaints(String uid) async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("binder").document(uid).collection("complaint").getDocuments();
    StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('binder')
            .document(uid)
            .collection('complaint')
            .snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Loading()
              : ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.documents.length,
            // ignore: missing_return
            itemBuilder: (_, index) {
              DocumentSnapshot data =
              snapshot.data.documents[index];
              print(data['issue']);
              allComplaintData.add(Complaint(
                assignedDate: data['assignedDate'],
                assignedTime: data['assignedTime'],
                assignedTo: data['assignedTo'],
                department: data['department'],
                endDate: data['endDate'],
                endTime: data['endTime'],
                issue: data['issue'],
                lineNo: data['lineNo'],
                machineNo: data['machineNo'],
                raisedBy: data['raisedBy'],
                startDate: data['startDate'],
                startTime: data['startTime'],
                status: data['status'],
                verifiedDate: data['verifiedDate'],
                verifiedTime: data['verifiedTime'],
              ));
            },
          );
        });
    return querySnapshot.documents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(
          backIcon: false,
          child: Text(
            'Department Complaints',
            style: titleText,
          )),
//
      body: FutureBuilder(
          future: getAllDocuments(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(top: 140),
                  child: Column(
                    children: <Widget>[
                      new Image.asset(
                        'assets/images/sitting-4.png',
                        scale: 1.5,
                      ),
                      new Text(
                        "Looks like you have no complaints",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFF5e5e5e)),
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Column(
                children: allComplaintData.map((complaint) {
//                  return StreamBuilder<QuerySnapshot>(
//                      stream: Firestore.instance
//                          .collection('binder')
//                          .document(e)
//                          .collection('complaint')
//                          .snapshots(),
//                      builder: (context, snapshot) {
//                        return !snapshot.hasData
//                            ? Loading()
//                            : ListView.builder(
//                                shrinkWrap: true,
//                                itemCount: snapshot.data.documents.length,
//                                itemBuilder: (_, index) {
//                                  DocumentSnapshot data =
//                                      snapshot.data.documents[index];
//                                  print(data['issue']);
//                                  Color cstatus;
//                                  if (data['status'] == 'solved') {
//                                    cstatus = complaintStatusSolved;
//                                  } else if (data['status'] == 'ongoing') {
//                                    cstatus = complaintStatusOngoing;
//                                  } else if (data['status'] == 'notsolved') {
//                                    cstatus = complaintStatusNotSolved;
//                                  } else if (data['status'] == 'pending') {
//                                    cstatus = complaintStatusPending;
//                                  } else if (data['status'] ==
//                                      'transferAME') {
//                                    cstatus = complaintStatusAME;
//                                  }
//                                  return CustomComplaintCard(
//                                    userDetails: widget.userDetails,
//                                    complaintNo: data.documentID,
//                                    title: data["issue"],
//                                    machineno: data["machineno"],
//                                    date: data["startDate"],
//                                    department: data["department"],
//                                    cstatus: cstatus,
//                                  );
//                                },
//                              );
//                      });
//                return FutureBuilder(
//                  future: getAllDocuments(),
//                  builder: (_,snapshot){
//                    print('Complaint List: ' + allComplaintData.length.toString());
//                    if(snapshot.connectionState == ConnectionState.waiting){
//                      return Loading();
//                    }
//                    else{
//                      return Column(
//                        children: allComplaintData.map((Complaint complaint){
//                          print(complaint.issue);
//                          return TestCustomComplaintCard(
//                            complaint: complaint,
//                          );
//                        }).toList(),
//                      );
//                    }
//                  },
//                );
                return TestCustomComplaintCard(complaint: complaint,);
                }).toList(),
              );
            }
          }),
    );
  }
}

/*
* ==================================================================================================================================================
* */

class productionDeptComplaints extends StatefulWidget {
  final UserDetails userDetails;

  const productionDeptComplaints({Key key, this.userDetails}) : super(key: key);

  @override
  _productionDeptComplaintsState createState() =>
      _productionDeptComplaintsState();
}

class _productionDeptComplaintsState extends State<productionDeptComplaints> {
  final List<int> complaintNo = [1, 2, 3, 4, 5, 6];
  List<myData> allData = [];

  @override
  void initState() {
    print(1);

    fetchDepartmentComplaints();
  }

  void fetchDepartmentComplaints() async {
    Color cstatus;

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
          .collection('complaint')
          .getDocuments();
      final List<DocumentSnapshot> docComplaints = userComplaints.documents;
      for (DocumentSnapshot docComplaint in docComplaints) {
        print(docComplaint.documentID + " => " + docComplaint.data['issue']);
        if (docComplaint.data['status'] == 'solved') {
          cstatus = complaintStatusSolved;
        } else if (docComplaint.data['status'] == 'ongoing') {
          cstatus = complaintStatusOngoing;
        } else if (docComplaint.data['status'] == 'notsolved') {
          cstatus = complaintStatusNotSolved;
        } else if (docComplaint.data['status'] == 'pending') {
          cstatus = complaintStatusPending;
        } else if (docComplaint.data['status'] == 'transferAME') {
          cstatus = complaintStatusAME;
        }
        myData d = new myData(
            docComplaint.data['issue'],
            docComplaint.data['machineNo'],
            docComplaint.data['startDate'],
            docComplaint.data['department'],
            docComplaint.documentID,
            cstatus);
        allData.add(d);
      }
    }
    setState(() {
      print(allData.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(
          backIcon: false,
          child: Text(
            'Department Complaints',
            style: titleText,
          )),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemCount: allData.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomComplaintCard(
            complaintNo: allData[index].id,
            title: allData[index].title,
            machineno: allData[index].machineno,
            date: allData[index].date,
            department: allData[index].department,
            cstatus: allData[index].cstatus,
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 18.0,
        ),
      ),
    );
  }
}
