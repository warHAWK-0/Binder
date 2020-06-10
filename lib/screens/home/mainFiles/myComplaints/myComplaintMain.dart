import 'dart:io';

import 'package:final_binder/models/myData.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/screens/home/mainFiles/myComplaints/addcomplaint.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CustomComplaintCard.dart';

// ignore: camel_case_types
class myComplaints extends StatefulWidget {
  final UserDetails userDetails;

  const myComplaints({Key key, this.userDetails}) : super(key: key);

  @override
  _myComplaintsState createState() => _myComplaintsState();
}

// ignore: camel_case_types
class _myComplaintsState extends State<myComplaints> {
  final List<int> complaintNo = [1, 2, 3, 4, 5, 6];
  List<myData> allData = [];

  @override
  void initState() {
    print(1);
//    DatabaseReference ref = FirebaseDatabase.instance.reference();
//    ref.child('complaint').once().then((DataSnapshot snap) {
//      var keys = snap.value.keys;
//      var data = snap.value;
//      print(keys);
//      print(data);
//      allData.clear();
//      for (var key in keys) {
//        myData d = new myData(
//          data[key]['title'],
//          data[key]['machineno'],
//          data[key]['date'],
//          data[key]['department'],
//        );
//        allData.add(d);
//      }
//      setState(() {
//        print(allData.length);
//      });
//    });
  }

  Future<bool> _onbackpressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: new Text('Are you sure?'),
              content: new Text('Do you want to exit the App?'),
              actions: <Widget>[
                OutlineButton(
                  child: Text('Yes'),
                  onPressed: () => exit(0),
                ),
                OutlineButton(
                  child: Text('No'),
                  onPressed: () => Navigator.pop(context, false),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: Scaffold(
        //backgroundColor: Color(0xFFE5E5E5),
        appBar: CustomAppBar(
            backIcon: false,
            child: Text(
              'My Complaints',
              style: titleText,
            )),
        body: Stack(
          children: <Widget>[
            new Container(
                padding: EdgeInsets.only(top: 60),
                child: allData.length == 0
                    ? new Center(
                  child: Container(
                    margin: EdgeInsets.only(top:140),
                    child: Column(
                      children: <Widget>[
                        new Image.asset('assets/images/sitting-4.png',scale: 1.5,),
                        new Text("Looks like you have no complaints", style: TextStyle(fontSize: 18 , color: Color(0xFF5e5e5e)),)
                      ],
                    ),
                  ),
                )
                    : new ListView.builder(
                        itemCount: allData.length,
                        itemBuilder: (_, index) {
                          return CustomComplaintCard(
                            complaintNo: complaintNo[index],
                            title: allData[index].title,
                            machineno: allData[index].machineno,
                            date: allData[index].date,
                            department: allData[index].department,
                            //allData[index].pno,
                          );
                        },
                      )),
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: primaryblue,
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            elevation: 25.0,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return addComplaint(userDetails: widget.userDetails,);
              }));
            }),
      ),
    );
  }
}
