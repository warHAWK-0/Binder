class UserDetails{
  String name,
  uid,
  authLevel,
  department,
  mobileNo,
  personalId,
  email,
  //password,
  bayNo;

  UserDetails({
    this.name,
    this.authLevel,
    this.mobileNo,
    this.bayNo,
    this.uid,
    this.department,
    //this.password,
    this.personalId,
    this.email
  });


  Map<String, dynamic> toJson() => {
    "name": name,
    "uid": uid,
    "authLevel": authLevel,
    "department" : department,
    "mobileNo" : mobileNo,
    "personalId" : personalId,
    "email": email,
    //"password" : password,
    "bayNo" : bayNo,
  };
}