import 'package:flutter/cupertino.dart';

class UserDetails{
  String name,
  uid,
  authLevel,
  department,
  mobileNo,
  personalId,
  email,
  password,
  bayNo;

  UserDetails({
    this.name,
    this.authLevel,
    this.mobileNo,
    this.bayNo,
    this.uid,
    this.department,
    this.password,
    this.personalId,
    this.email
  });
}