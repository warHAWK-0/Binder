import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmapp/ReusableWidgets/themes.dart';

class CustomAppBar extends PreferredSize {
  final bool backIcon;
  final Widget child;
  final bool elevation;

  @override
  final Size preferredSize;

  CustomAppBar({
    this.backIcon = true,
    @required this.child,
    this.elevation = true
  }) : assert(child != null),
        preferredSize = Size.fromHeight(60.0);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.only(left: 10,bottom: 5),
        decoration: BoxDecoration(
          color: primaryblue,
        ),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: child,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: backIcon == true ? GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),
              ) : Container(
                height: 50,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Logo/LogoWhite/LogoWhiteS.png'),fit: BoxFit.fill,
                  )
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}