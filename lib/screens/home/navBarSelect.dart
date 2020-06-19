import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/CustomBottomNavigationBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';

import 'mainFiles/admin/adminMain.dart';
import 'mainFiles/departmentComplaints/deptComplaintsMain.dart';
import 'mainFiles/myComplaints/myComplaintMain.dart';
import 'mainFiles/myProfile/profileMain.dart';

class NavBarSelect extends StatefulWidget {

  final UserDetails userDetails;

  const NavBarSelect({Key key, this.userDetails}) : super(key: key);

  @override
  _NavBarSelectState createState() => _NavBarSelectState();
}

class _NavBarSelectState extends State<NavBarSelect> {

  int currentIndex = 0;

  // widget.authLevel == 0 && widget.userDepartment == "maintenance" <=> Maintenance operator
  List<Widget> _maintenanceOperatorScreenList() => [
    myComplaints(userDetails: widget.userDetails,),
    ProfileMain(userDetails: widget.userDetails,),
  ];

  //widget.authLevel == 1  && widget.userDepartment  == "maintenance" <=> Maintenance Supervisor
  List<Widget> _maintenanceSupervisorScreenList() => [
    deptComplaints(userDetails: widget.userDetails,),
    ProfileMain(userDetails: widget.userDetails,),
  ];

  // widget.authLevel == 0 && widget.userDepartment == "production" <=> Production operator
  List<Widget> _productionOperatorScreenList() => [
    myComplaints(userDetails: widget.userDetails,),
    ProfileMain(userDetails: widget.userDetails,),
  ];

  //widget.authLevel == 1 && widget.userDepartment = "production" <=> Production Supervisor
  List<Widget> _productionSupervisorScreenList() => [
    myComplaints(userDetails: widget.userDetails,),
    deptComplaints(userDetails: widget.userDetails,),
    ProfileMain(userDetails: widget.userDetails,),
  ];

  //widget.authLevel == 2 && userDepartment == "admin" <=> System Admin
  List<Widget> _systemAdminScreenList() => [
    AdminMain(userDetails: widget.userDetails,),
  ];

  @override
  Widget build(BuildContext context) {

    final List<Widget> productionOperatorScreenList = _productionOperatorScreenList();
    final List<Widget> maintenanceOperatorScreenList = _maintenanceOperatorScreenList();
    final List<Widget> productionSupervisorScreenList = _productionSupervisorScreenList();
    final List<Widget> maintenanceSupervisorScreenList = _maintenanceSupervisorScreenList();
    final List<Widget> systemAdminScreenList = _systemAdminScreenList();

    return Scaffold(
      body: (widget.userDetails.authLevel == '0' && widget.userDetails.department == "maintenance") ? maintenanceOperatorScreenList[currentIndex] :
      (widget.userDetails.authLevel == '0' && widget.userDetails.department == "production") ? productionOperatorScreenList[currentIndex] :
      (widget.userDetails.authLevel == '1'  && widget.userDetails.department  == "maintenance") ? maintenanceSupervisorScreenList[currentIndex] :
      (widget.userDetails.authLevel == '1'&& widget.userDetails.department == "production") ? productionSupervisorScreenList[currentIndex] :
      (widget.userDetails.authLevel == '2' && widget.userDetails.department == "admin") ? systemAdminScreenList[currentIndex] : null,
      bottomNavigationBar: (widget.userDetails.authLevel == '0' && widget.userDetails.department == "maintenance") == true ? BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 10,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Complaints'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ) :
      (widget.userDetails.authLevel == '1' && widget.userDetails.department == "maintenance") == true ? BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 10,
        curve: Curves.easeInBack,
        onItemSelected: (index) =>
            setState(() {
              currentIndex = index;
            }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Department'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ) :
      (widget.userDetails.authLevel == '0' && widget.userDetails.department == "production") == true ? BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 10,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Complaints'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ) :
      (widget.userDetails.authLevel == '1' && widget.userDetails.department == "production") == true ? BottomNavyBar(
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 10,
        curve: Curves.easeInBack,
        onItemSelected: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.message),
            title: Text('Complaints'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_balance),
            title: Text('Department'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
            activeColor: primaryblue,
            inactiveColor: Colors.white,
            textAlign: TextAlign.center,
          ),
        ],
      ) :
      (widget.userDetails.authLevel == '2' && widget.userDetails.department == "admin") == true ? null : null,
    );
  }
}

