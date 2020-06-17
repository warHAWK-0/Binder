import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'ExpandedComplaintCard.dart';

class CustomComplaintCard extends StatefulWidget {

  final Complaint complaint;
  final UserDetails userDetails;

  const CustomComplaintCard({
    Key key,
    this.complaint,
    this.userDetails,
  }) : super(key: key);

  @override
  _CustomComplaintCardState createState() => _CustomComplaintCardState();
}

class _CustomComplaintCardState extends State<CustomComplaintCard> {
  @override
  Widget build(BuildContext context) {
    print(widget.complaint.issue);
    return Material(
      child: InkWell(
        onTap: () async {
//          final QuerySnapshot result =
//          await Firestore.instance.collection('binder').document(widget.userDetails.uid).collection('complaint').getDocuments();
//          final List<DocumentSnapshot> documents = result.documents;
//          for (DocumentSnapshot document in documents) {
//            print(document.documentID + " => " + document.data['issue']);
//            if (document.documentID==widget.complaintNo){
//              d = new myData2(
//                  document.data['issue'],
//                  document.data['machineNo'],
//                  document.data['lineNo'],
//                  document.data['status'],
//                  document.data['raisedby'],
//                  document.data['startTime'],
//                  document.data['assignedTo'],
//                  document.data['assignedBy'],
//                  document.data['description'],
//                  document.data['startDate'],
//                  document.data['department']
//              );
////                if(document.data['status']=='solved'){
////                  wcstatus=complaintStatusSolved;
////                }
////                else if (document.data['status']=='ongoing'){
////                  cstatus=complaintStatusOngoing;
////                }
////                else if(document.data['status']=='notsolved'){
////                  cstatus=complaintStatusNotSolved;
////                }
////                else if(document.data['status']=='pending'){
////                  cstatus=complaintStatusPending;
////                }
////                else if(document.data['status']=='transferAME'){
////                  cstatus=complaintStatusAME;
////                }
//            }
//
//          }
          if(widget.userDetails.authLevel=="0" && widget.userDetails.department=="maintenance"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>ExpandedComplainStatus(
                userDetails:widget.userDetails,
                complaint: widget.complaint,
              )),
            );
          }
          else if(widget.userDetails.authLevel=="1" && widget.userDetails.department=="maintenance"){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>ExpandedComplaintAssign(
                userDetails:widget.userDetails,
                complaint: widget.complaint,
              )),
            );
          }
          else{
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExpandedComplainVerify(
                userDetails:widget.userDetails,
                complaint: widget.complaint,
              )),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,),
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1.0,color: Colors.grey[200]),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey[200],
                  offset: Offset(3.0, 2.0),
                )
              ]),
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
                          widget.complaint.issue.toString(),
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
                            widget.complaint.machineNo,
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
                      child: Icon(
                        Icons.brightness_1,
                        color: widget.complaint.status == "solved" ? complaintStatusSolved
                            : widget.complaint.status == "ongoing" ? complaintStatusOngoing
                            : widget.complaint.status == "pending" ? complaintStatusPending
                            : widget.complaint.status == "notsolved" ? complaintStatusNotSolved
                            : widget.complaint.status == "transferAME" ? complaintStatusAME
                            : widget.complaint.status == "raised" ? Colors.red : Colors.black,
                      )
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    child: Text(
                        widget.complaint.startDate,
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
                        widget.complaint.department.substring(0,1).toUpperCase()+
                        widget.complaint.department.substring(1,widget.complaint.department.length),
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
    );
  }
}
