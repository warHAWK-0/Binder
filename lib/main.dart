import 'package:final_binder/screens/home/mainFiles/admin/deleteemployee.dart';
import 'package:final_binder/screens/home/mainFiles/departmentComplaints/deptComplaintsMain.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_binder/screens/home/mainFiles/admin/editSearchEmp.dart';
import 'models/user.dart';
import 'screens/home/mainFiles/admin/addemployee.dart';
import 'screens/wrapper.dart';
import 'services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      )
    );
  }
}
