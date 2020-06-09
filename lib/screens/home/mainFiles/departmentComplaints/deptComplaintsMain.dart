import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/CustomAppBar.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';
import 'package:tmapp/screens/MainFiles/myComplaints/CustomComplaintCard.dart';

class maintenanceDeptComplaints extends StatefulWidget {

  final int authLevel;
  final String userDepartment;

  const maintenanceDeptComplaints({
    Key key,
    @required this.authLevel,
    @required this.userDepartment
  }) : super(key: key);

  @override
  _maintenanceDeptComplaintsState createState() => _maintenanceDeptComplaintsState();
}

class _maintenanceDeptComplaintsState extends State<maintenanceDeptComplaints> {
  final List<int> complaintNo = [1,2,3,4,5,6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(backIcon: false, child: Text('My Complaints',style: titleText,)),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        itemCount: complaintNo.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomComplaintCard(complaintNo: complaintNo[index],);
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
  final int authLevel;
  final String userDepartment;

  const productionDeptComplaints({
    Key key,
    @required this.authLevel,
    @required this.userDepartment
  }) : super(key: key);

  @override
  _productionDeptComplaintsState createState() => _productionDeptComplaintsState();
}

class _productionDeptComplaintsState extends State<productionDeptComplaints> {
  final List<int> complaintNo = [1,2,3,4,5,6];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(backIcon: false, child: Text('My Complaints',style: titleText,)),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
        itemCount: complaintNo.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomComplaintCard(complaintNo: complaintNo[index],);
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: 18.0,
        ),
      ),
    );
  }
}

