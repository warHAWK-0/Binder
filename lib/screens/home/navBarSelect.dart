import 'package:Binder/models/user_data.dart';
import 'package:Binder/shared/CustomBottomNavigationBar.dart';
import 'package:Binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'mainFiles/departmentComplaints/StatisticsReport.dart';
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
  final PageStorageBucket bucket = PageStorageBucket();
  final Key complaint = PageStorageKey("My Complaints");
  final Key departmentComplaint = PageStorageKey("Department Complaints");

  int currentIndex = 0;

  // widget.authLevel == 0 && widget.userDepartment == "maintenance" <=> Maintenance operator
  List<Widget> _maintenanceOperatorScreenList() => [
    myComplaints(userDetails: widget.userDetails,),
    ProfileMain(userDetails: widget.userDetails,),
  ];

  //widget.authLevel == 1  && widget.userDepartment  == "maintenance" <=> Maintenance Supervisor
  List<Widget> _maintenanceSupervisorScreenList() => [

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
      body: (widget.userDetails.authLevel == '0' && widget.userDetails.department == "maintenance") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          myComplaints(key: complaint,userDetails: widget.userDetails,),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '0' && widget.userDetails.department == "production") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          myComplaints(key: complaint,userDetails: widget.userDetails,),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '1'  && widget.userDetails.department  == "maintenance") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          deptComplaints(key: departmentComplaint,userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '1'&& widget.userDetails.department == "production") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          myComplaints(key: complaint,userDetails: widget.userDetails,),
          deptComplaints(key: departmentComplaint,userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),

        ],
      )
          : (widget.userDetails.authLevel == '4' && widget.userDetails.department == "production") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          myComplaints(key: complaint,userDetails: widget.userDetails,),
          deptComplaints(key: departmentComplaint, userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '3' && widget.userDetails.department == "production") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          myComplaints(key: complaint,userDetails: widget.userDetails,),
          deptComplaints(key: departmentComplaint, userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '4' && widget.userDetails.department == "maintenance") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          deptComplaints(key: departmentComplaint, userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '3' && widget.userDetails.department == "maintenance") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          deptComplaints(key: departmentComplaint, userDetails: widget.userDetails,),
          StatisticsReport(userDetails: widget.userDetails),
          ProfileMain(userDetails: widget.userDetails,),
        ],
      )
          : (widget.userDetails.authLevel == '2' && widget.userDetails.department == "admin") ? IndexedStack(
        index: currentIndex,
        children: <Widget>[
          AdminMain(userDetails: widget.userDetails,),
        ],
      )
          : Scaffold(
        body: Center(
          child: Container(
            child: Column(
            children: <Widget>[
              Text('The user might have been removed by admin')
            ],
            ),
          ),
        ),
      ),
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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
      (widget.userDetails.authLevel == '3' && widget.userDetails.department == "production") == true ? BottomNavyBar(
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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
      (widget.userDetails.authLevel == '4' && widget.userDetails.department == "production") == true ? BottomNavyBar(
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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
      (widget.userDetails.authLevel == '3' && widget.userDetails.department == "maintenance") == true ? BottomNavyBar(
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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
      (widget.userDetails.authLevel == '4' && widget.userDetails.department == "maintenance") == true ? BottomNavyBar(
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
            icon: Icon(Icons.timeline),
            title: Text('Statistics'),
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

