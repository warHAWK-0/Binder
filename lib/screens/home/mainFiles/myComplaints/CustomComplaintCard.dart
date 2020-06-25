import 'package:Binder/models/complaint.dart';
import 'package:Binder/models/user_data.dart';
import 'package:Binder/screens/home/mainFiles/myComplaints/ExpandedComplaintCard.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/material.dart';

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
        onTap: (){
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
              MaterialPageRoute(builder: (context) => ExpandedComplaintAssign(
                userDetails:widget.userDetails,
                complaint: widget.complaint,
              )),
            );
          }
          else if((widget.userDetails.authLevel=="1" && widget.userDetails.department=="production" ) || (widget.userDetails.authLevel=="0" && widget.userDetails.department=="production")){
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => ExpandedComplainVerify(userDetails: widget.userDetails, complaint: widget.complaint)
            ));
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
                            : widget.complaint.status == "cannotBeResolved" ? complaintStatusCannotBeResolved
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
                        widget.complaint.typeofIssue,
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
