import 'package:flutter/material.dart';
import 'package:tmapp/MainFiles/myComplaints/ExpandedComplaintCard.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';

class CustomComplaintCard extends StatefulWidget {

  final int complaintNo;
  final String userDepartment;
  final String title, machineno, date,department;


  const CustomComplaintCard({
    Key key,
    @required this.complaintNo,
    @required this.userDepartment,
    @required this.title,
    @required this.machineno,
    @required this.date,
    @required this.department,

  }) : super(key: key);

  @override
  _CustomComplaintCardState createState() => _CustomComplaintCardState();
}

class _CustomComplaintCardState extends State<CustomComplaintCard> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Complaint-' + widget.complaintNo.toString(),
      child: Material(
        child: InkWell(
          onTap: (){
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpandedComplaintAssign(complaintNo: widget.complaintNo,)),
              );
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: EdgeInsets.only(left: 15,right: 15),
            child: Card(
              elevation: 2.5,
              /*decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                 /* boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 2.0),
                    )
                  ]*/
              ),*/
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 5),
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
                            margin: EdgeInsets.only(top: 5,left: 5),
                            child: Text(
                                widget.machineno.toString(),
                                style: TextStyle(
                                    fontFamily: 'Roboto',
                                    color: primaryblue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 5,right: 5),
                          child: Icon(Icons.brightness_1,color: Color(0xFFFF5656),)
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Text(
                            widget.date.toString(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: primaryblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        child: Text(
                            widget.department.toString(),
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: primaryblue,
                                fontSize: 14,
                                fontWeight: FontWeight.w500)),
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
