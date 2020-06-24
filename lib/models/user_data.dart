class UserDetails{
  String name,
  uid,
  authLevel,
  typeofOperator,
  department,
  mobileNo,
  lineNo,
  personalId,
  email,
  firstLogin,
  bayNo;

  UserDetails({
    this.name,
    this.authLevel,
    this.mobileNo,
    this.bayNo,
    this.typeofOperator,
    this.uid,
    this.lineNo,
    this.department,
    this.firstLogin,
    this.personalId,
    this.email
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "authLevel": authLevel,
    "department" : department,
    "mobileNo" : mobileNo,
    "LineNo": lineNo,
    'typeOfOperator': typeofOperator,
    "personalId" : personalId,
    "email": email,
    "firstLogin" : firstLogin,
    "bayNo" : bayNo,
  };
}