import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'ExpandedComplaintCard.dart';
import 'package:final_binder/models/mydata2.dart';

class CustomComplaintCard extends StatefulWidget {

  final String complaintNo;
  final String userDepartment;
  final String title, machineno, date,department;
  final UserDetails userDetails;
  final Color cstatus;



  const CustomComplaintCard({
    Key key,
    @required this.userDetails,
    @required this.complaintNo,
    @required this.userDepartment,
    @required this.title,
    @required this.machineno,
    @required this.date,
    @required this.department,
    @required this.cstatus

  }) : super(key: key);

  @override
  _CustomComplaintCardState createState() => _CustomComplaintCardState();
}

class _CustomComplaintCardState extends State<CustomComplaintCard> {
  myData2 d;
  //Color cstatus;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Complaint-' + widget.complaintNo,
      child: Material(
        child: InkWell(
          onTap: () async {
            final QuerySnapshot result =
            await Firestore.instance.collection('binder').document(widget.userDetails.uid).collection('complaint').getDocuments();
            final List<DocumentSnapshot> documents = result.documents;
            for (DocumentSnapshot document in documents) {
              print(document.documentID + " => " + document.data['issue']);
              if (document.documentID==widget.complaintNo){
                d = new myData2(
                    document.data['issue'],
                    document.data['machineNo'],
                    document.data['lineNo'],
                    document.data['status'],
                    document.data['raisedby'],
                    document.data['startTime'],
                    document.data['assignedTo'],
                    document.data['assignedBy'],
                    document.data['description'],
                    document.data['startDate'],
                    document.data['department']
                );
//                if(document.data['status']=='solved'){
//                  wcstatus=complaintStatusSolved;
//                }
//                else if (document.data['status']=='ongoing'){
//                  cstatus=complaintStatusOngoing;
//                }
//                else if(document.data['status']=='notsolved'){
//                  cstatus=complaintStatusNotSolved;
//                }
//                else if(document.data['status']=='pending'){
//                  cstatus=complaintStatusPending;
//                }
//                else if(document.data['status']=='transferAME'){
//                  cstatus=complaintStatusAME;
//                }
              }

            }
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpandedComplaintAssign(userDetails:widget.userDetails,complaintNo: widget.complaintNo,ma:d,cstatus: widget.cstatus,)),
              );
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10,left: 12),
                            child: Text(
                              widget.title.toString(),
                              style: TextStyle(
                                fontFamily: 'Roboto',
                                color: primaryblue,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 12),
                            child: Text(
                                widget.machineno.toString(),
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: primaryblue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400)
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                          margin: EdgeInsets.only(top: 5,right: 5),
                          child: Icon(Icons.brightness_1,color: widget.cstatus,)
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 12),
                        child: Text(
                            widget.date.toString(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: primaryblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(right: 8),
                        child: Text(
                            widget.department.toString().toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: primaryblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
