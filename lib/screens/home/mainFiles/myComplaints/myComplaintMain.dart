import 'dart:io';
import 'package:final_binder/models/myData.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/addcomplaint.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomComplaintCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: camel_case_types
class myComplaints extends StatefulWidget {
  final UserDetails userDetails;
  const myComplaints({Key key, this.userDetails}) : super(key: key);
  @override
  _myComplaintsState createState() => _myComplaintsState();
}

// ignore: camel_case_types
class _myComplaintsState extends State<myComplaints> {
  List<myData> allData = [];


  @override
  void initState(){
    //fetchComplaints();
  }
//  void fetchComplaints() async{
//   // Color cstatus;
//    final QuerySnapshot result =
//    await Firestore.instance.collection('binder').document(widget.userDetails.uid).collection('complaint').getDocuments();
//    final List<DocumentSnapshot> documents = result.documents;
//    allData.clear();
//    for (DocumentSnapshot document in documents) {
//      print(document.documentID + " => " + document.data['issue']);
//      if(document.data['status']=='solved'){
//        cstatus=complaintStatusSolved;
//      }
//      else if (document.data['status']=='ongoing'){
//        cstatus=complaintStatusOngoing;
//      }
//      else if(document.data['status']=='notsolved'){
//        cstatus=complaintStatusNotSolved;
//      }
//      else if(document.data['status']=='pending'){
//        cstatus=complaintStatusPending;
//      }
//      else if(document.data['status']=='transferAME'){
//        cstatus=complaintStatusAME;
//      }
//      myData d = new myData(
//          document.data['issue'],
//          document.data['machineNo'],
//          document.data['startDate'],
//          document.data['department'],
//          document.documentID,
//          cstatus
//      );
//      allData.add(d);
//
//    }
//
//    setState(() {
//      print(allData.length);
//    });
//  }

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit the App?'),
          actions: <Widget>[
            OutlineButton(
              child: Text('Yes'),
              onPressed: () => exit(0),
            ),
            OutlineButton(
              child: Text('No'),
              onPressed: () => Navigator.pop(context, false),
            )
          ],
        ));
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
                      stream: Firestore.instance.collection('binder').document(widget.userDetails.uid).collection('complaint').snapshots(),
                      builder: (context, snapshot) {
                        return !snapshot.hasData
                            ? new Center(
                        child: Container(
                        margin: EdgeInsets.only(top:140),
                        child: Column(
                        children: <Widget>[
                        new Image.asset('assets/images/sitting-4.png',scale: 1.5,),
                        new Text("Looks like you have no complaints", style: TextStyle(fontSize: 18 , color: Color(0xFF5e5e5e)),)
                        ],
                        ),
                        ),
                        )
                        : new ListView.builder(
                          itemCount: snapshot.data.documents.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot data=snapshot.data.documents[index];
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
                    )),
          ],
        ),

        floatingActionButton: FloatingActionButton(
            backgroundColor: primaryblue,
            child: Icon(Icons.add,size: 40,
              color: Colors.white,
            ),
            onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => addComplaint(userDetails: widget.userDetails,)));
          }
        ),
      ),
    );
  }
}
