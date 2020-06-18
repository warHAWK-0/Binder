import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/CustomComplaintCard.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class deptComplaints extends StatefulWidget {
  final UserDetails userDetails;

  const deptComplaints({Key key, this.userDetails})
      : super(key: key);

  @override
  _deptComplaintsState createState() =>
      _deptComplaintsState();
}

class _deptComplaintsState extends State<deptComplaints> {
  List<String> documentNames = [];
  bool loading = false;

  Future getAllDocuments() async{
    QuerySnapshot querySnapshot = await Firestore.instance.collection("binder").getDocuments();
    documentNames.clear();
    for(DocumentSnapshot documentSnapshot in querySnapshot.documents){
      documentNames.add(documentSnapshot.documentID.toString());
    }
    return querySnapshot.documents;
  }

  bool hasComplaint = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(backIcon: false, child: Text('Department Complaints',style: titleText,)),

      body: SingleChildScrollView(
        child: FutureBuilder(
          future: getAllDocuments(),
          builder: (_,snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height/3.3,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: SpinKitFadingCircle(
                      size: 60,
                      color: primaryblue,
                    ),
                  ),
                  Text(
                    'Looking for Department complaints...',
                    style: TextStyle(
                      color: primaryblue,
                      fontSize: 15,
                    ),
                  ),
                ],
              );
            }
            else{
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: documentNames.map((uid){
                    return StreamBuilder(
                      stream: Firestore.instance.collection("binder").document(uid)
                          .collection("complaint").snapshots(),
                      builder: (_,snapshot){
                        if(!snapshot.hasData){
                          return Container();
                        }
                        else{
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (_,index){
                              return CustomComplaintCard(
                                  userDetails: widget.userDetails,
                                  complaint: Complaint(
                                    complaintId: uid,
                                    assignedDate: snapshot.data.documents[index]['assignedDate'],
                                    assignedTime: snapshot.data.documents[index]['assignedTime'],
                                    assignedTo:[ snapshot.data.documents[index]['assignedTo']],
                                    department: snapshot.data.documents[index]['department'],
                                    endDate: snapshot.data.documents[index]['endDate'],
                                    endTime: snapshot.data.documents[index]['endDate'],
                                    mobileNo: snapshot.data.documents[index]['mobileNo'],
                                    issue: snapshot.data.documents[index]['issue'],
                                    lineNo: snapshot.data.documents[index]['lineNo'],
                                    machineNo: snapshot.data.documents[index]['machineNo'],
                                    raisedBy: snapshot.data.documents[index]['raisedBy'],
                                    raisedByUid: snapshot.data.documents[index]['raisedByUid'],
                                    startDate: snapshot.data.documents[index]['startDate'],
                                    startTime: snapshot.data.documents[index]['startTime'],
                                    status: snapshot.data.documents[index]['status'],
                                    typeofIssue: snapshot.data.documents[index]['typeofIssue'],
                                    verifiedDate: snapshot.data.documents[index]['verifiedDate'],
                                    verifiedTime: snapshot.data.documents[index]['verifiedTime'],
                                  )
                              );
                            },
                          );
                        }
                      },
                    );
                  }).toList(),
                ),
              );

            }
          },
        ),
      ),
    );
  }
}

