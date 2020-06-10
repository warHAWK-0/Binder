import 'package:flutter/cupertino.dart';

class UserDetails{
  String name,
  uid,
  designation,
  mobileNo,
  bay_no;

  UserDetails({this.name,this.designation,this.mobileNo, this.bay_no, this.uid});

  Map<String, dynamic> toJson() => {
    'name': name,
    'designation': designation,
    'mobile_no': mobileNo,
    'bay_no': bay_no,
  };
}