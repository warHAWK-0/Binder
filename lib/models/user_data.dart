class UserDetails{
  String name,
      designation,
      mobileNo,
      bay_no;

  UserDetails({this.name, this.designation,this.mobileNo, this.bay_no});

  Map<String, dynamic> toJson() => {
    'name': name,
    'designation': designation,
    'mobile_no': mobileNo,
    'bay_no': bay_no,
  };
}