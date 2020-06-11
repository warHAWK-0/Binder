import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:final_binder/models/myData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class maintenanceDeptComplaints extends StatefulWidget {

  final UserDetails userDetails;

  const maintenanceDeptComplaints({Key key, this.userDetails}) : super(key: key);



  @override
  _maintenanceDeptComplaintsState createState() => _maintenanceDeptComplaintsState();
}

class _maintenanceDeptComplaintsState extends State<maintenanceDeptComplaints> {
  final List<int> complaintNo = [1,2,3,4,5,6];
  List<myData> allData = [];

  @override
  void initState(){
    print(1);

    fetchDepartmentComplaints();
  }
  void fetchDepartmentComplaints() async {

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
        myData d = new myData(
            docComplaint.data['issue'],
            docComplaint.data['machineNo'],
            docComplaint.data['startDate'],
            docComplaint.data['department'],
            docComplaint.documentID);
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
      appBar: CustomAppBar(backIcon: false, child: Text('My Complaints',style: titleText,)),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        itemCount: allData.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomComplaintCard(
            complaintNo: allData[index].id,
            title: allData[index].title,
            machineno: allData[index].machineno,
            date: allData[index].date,
            department: allData[index].department,
            //allData[index].pno,
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 18.0,
        ),
      ),
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
  _productionDeptComplaintsState createState() => _productionDeptComplaintsState();
}

class _productionDeptComplaintsState extends State<productionDeptComplaints> {
  final List<int> complaintNo = [1,2,3,4,5,6];
  List<myData> allData = [];

  @override
  void initState(){
    print(1);

    fetchDepartmentComplaints();
  }
  void fetchDepartmentComplaints() async {

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
        myData d = new myData(
            docComplaint.data['issue'],
            docComplaint.data['machineNo'],
            docComplaint.data['startDate'],
            docComplaint.data['department'],
            docComplaint.documentID);
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
      appBar: CustomAppBar(backIcon: false, child: Text('Department Complaints',style: titleText,)),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        itemCount: allData.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomComplaintCard(
            complaintNo: allData[index].id,
            title: allData[index].title,
            machineno: allData[index].machineno,
            date: allData[index].date,
            department: allData[index].department,
            //allData[index].pno,
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 18.0,
        ),
      ),
    );
  }
}

