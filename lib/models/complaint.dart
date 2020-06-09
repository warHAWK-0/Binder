class Complaint{

  String status,
  machineNo,
  department,
  issue,
  raisedBy,
  assignedTo,
  lineNo;
  DateTime startDateTime,
  assignedDateTime,
  endDateTime,
  verifiedDateTime;

  Complaint({
    this.status,
    this.machineNo,
    this.department,
    this.issue,
    this.raisedBy,
    this.assignedTo,
    this.lineNo,
    this.startDateTime,
    this.assignedDateTime,
    this.endDateTime,
    this.verifiedDateTime,
  });

  Map<String, dynamic> toJson() => {
  'status': status,
  'machineNo': machineNo,
  'department': department,
  'issue': issue,
  'raisedBy': raisedBy,
  'assignedTo': assignedTo,
  'lineNo': lineNo,
  'startDateTime': startDateTime,
  'assignedDateTime': assignedDateTime,
  'endDateTime': endDateTime,
  'verifiedDateTime': verifiedDateTime,
  };

}