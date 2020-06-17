class Complaint{

  String complaintId,
  status,
  machineNo,
  department,
  issue,
  typeofIssue,
  raisedBy,
  assignedBy,
  mobileNo,
  lineNo,
  startDate,startTime,
  assignedDate,assignedTime,
  endDate,endTime,
  verifiedDate,verifiedTime;
  List <dynamic> assignedTo;

  Complaint({
    this.complaintId,
    this.status,
    this.machineNo,
    this.department,
    this.issue,
    this.typeofIssue,
    this.raisedBy,
    this.assignedTo,
    this.lineNo,
    this.mobileNo,
    this.assignedBy,
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
    'typeofIssue':typeofIssue,
  'raisedBy': raisedBy,
  'assignedTo': assignedTo,
  'lineNo': lineNo,
  'startDate': startDate,
  'startTime': startTime,
  'assignedDate': assignedDate,
  'assignedTime': assignedTime,
  'endDate': endDate,
  'endTime': endTime,
  'assignedBy' : assignedBy,
  'mobileNo' : mobileNo,
  'verifiedDate': verifiedDate,
  'verifiedTime': verifiedTime,
  };

}