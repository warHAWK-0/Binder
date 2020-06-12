import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/loading.dart';
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

   // fetchDepartmentComplaints();
  }
//  void fetchDepartmentComplaints() async {
//    Color cstatus;
//
//    final QuerySnapshot usersList =
//    await Firestore.instance.collection('binder').getDocuments();
//    final List<DocumentSnapshot> docUsers = usersList.documents;
//    allData.clear();
//    for (DocumentSnapshot docUser in docUsers) {
//      String uidUser = docUser.documentID;
//      print(uidUser);
//      final QuerySnapshot userComplaints = await Firestore.instance
//          .collection('binder')
//          .document(uidUser)
//          .collection('complaint')
//          .getDocuments();
//      final List<DocumentSnapshot> docComplaints = userComplaints.documents;
//      for (DocumentSnapshot docComplaint in docComplaints) {
//        print(docComplaint.documentID + " => " + docComplaint.data['issue']);
//        if(docComplaint.data['status']=='solved'){
//          cstatus=complaintStatusSolved;
//        }
//        else if (docComplaint.data['status']=='ongoing'){
//          cstatus=complaintStatusOngoing;
//        }
//        else if(docComplaint.data['status']=='notsolved'){
//          cstatus=complaintStatusNotSolved;
//        }
//        else if(docComplaint.data['status']=='pending'){
//          cstatus=complaintStatusPending;
//        }
//        else if(docComplaint.data['status']=='transferAME'){
//          cstatus=complaintStatusAME;
//        }
//        myData d = new myData(
//            docComplaint.data['issue'],
//            docComplaint.data['machineNo'],
//            docComplaint.data['startDate'],
//            docComplaint.data['department'],
//            docComplaint.documentID,
//            cstatus);
//        allData.add(d);
//      }
//    }
//    setState(() {
//      print(allData.length);
//    });
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(backIcon: false, child: Text('Department Complaints',style: titleText,)),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("binder").snapshots(),
        // ignore: missing_return
        builder: (context,snapshot) {

          if(! snapshot.hasData){
            return Container(child: Text('not has data'),);
          }
          else{
            int index = snapshot.data.documents.length;
            final List<DocumentSnapshot> userDocs = snapshot.data.documents;

            for (DocumentSnapshot s in userDocs) {
              print(s.documentID);
              return StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("binder").document(s.documentID).collection("complaint").snapshots(),
                // ignore: missing_return
                builder: (context,snap){
                  if(! snap.hasData){
                    return Loading();
                  }
                  else{
                    return ListView.builder(
                      itemCount: snap.data.documents.length,
                      itemBuilder: (_, index) {
                        print(snap.data.documents.length);
                        DocumentSnapshot data=snap.data.documents[index];
                        print(snapshot.data.documents.length);
                        Color cstatus;
                        print(data['issue']);
                        if(data['status']=='solved'){
                          cstatus=complaintStatusSolved;
                        }
                        else if (data['status']=='ongoing'){
                          cstatus=complaintStatusOngoing;
                        }
                        else if(data['status']=='notsolved'){
                          cstatus=complaintStatusNotSolved;
                        }
                        else if(data['status']=='pending'){
                          cstatus=complaintStatusPending;
                        }
                        else if(data['status']=='transferAME') {
                          cstatus = complaintStatusAME;
                        }
                        return CustomComplaintCard(
                          userDetails: widget.userDetails,
                          complaintNo: data.documentID,
                          title: data["issue"],
                          machineno: data["machineno"],
                          date: data["startDate"],
                          department: data["department"],
                          cstatus: cstatus,
                        );
                      },
                    );
                  }
                },
              );
            }
          }
        },
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
        if(docComplaint.data['status']=='solved'){
          cstatus=complaintStatusSolved;
        }
        else if (docComplaint.data['status']=='ongoing'){
          cstatus=complaintStatusOngoing;
        }
        else if(docComplaint.data['status']=='notsolved'){
          cstatus=complaintStatusNotSolved;
        }
        else if(docComplaint.data['status']=='pending'){
          cstatus=complaintStatusPending;
        }
        else if(docComplaint.data['status']=='transferAME'){
          cstatus=complaintStatusAME;
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
            cstatus: allData[index].cstatus,
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