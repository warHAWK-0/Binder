import 'package:flutter/cupertino.dart';

class Complaint{

  String status,
  machineNo,
  department,
  issue,
  raisedBy,
  assignedTo;
  String lineNo,
  startDate,startTime,
  assignedDate,assignedTime,
  endDate,endTime,
  verifiedDate,verifiedTime;

  Complaint({
    this.status,
    this.machineNo,
    this.department,
    this.issue,
    this.raisedBy,
    this.assignedTo,
    this.lineNo,
    this.startDate,this.startTime,
    this.assignedDate,this.assignedTime,
    this.endDate,this.endTime,
    this.verifiedDate,this.verifiedTime,
  });

  Map<String, dynamic> toJson() => {
  'status': status,
  'machineNo': machineNo,
  'department': department,
  'issue': issue,
  'raisedBy': raisedBy,
  'assignedTo': assignedTo,
  'lineNo': lineNo,
  'startDate': startDate,
  'startTime': startTime,
  'assignedDate': assignedDate,
  'assignedTime': assignedTime,
  'endDate': endDate,
  'endTime': endTime,
  'verifiedDate': verifiedDate,
  'verifiedTime': verifiedTime,
  };

}