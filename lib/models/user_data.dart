class UserDetails{
  String name,
  uid,
  authLevel,
  typeofOperator,
  department,
  mobileNo,
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
    'typeOfOperator': typeofOperator,
    "personalId" : personalId,
    "email": email,
    //"password" : password,
    "bayNo" : bayNo,
  };
}