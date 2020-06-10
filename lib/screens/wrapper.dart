import 'file:///E:/AppDevProject/Flutter/NewBinder/lib/screens/home/redirectingHome.dart';

import '../models/user.dart';
import 'package:provider/provider.dart';
import 'authenticate/sign_in.dart';
import 'package:flutter/material.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return home or authenticate
    if(user == null){
      return SignIn();
    }else{
      return RedirectingScreen(user: user,);
    }
  }
}
