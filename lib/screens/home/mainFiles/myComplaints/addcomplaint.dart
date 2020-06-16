import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/complaint.dart';
import 'package:final_binder/models/user.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/shared/CustomAppBar.dart';
import 'package:final_binder/shared/themes.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class addComplaint extends StatefulWidget {
  final UserDetails userDetails;
  const addComplaint({Key key, this.userDetails}):super(key :key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<addComplaint> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key1 = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<String>> key2 = new GlobalKey();
  String type = "";
  List<String> suggestions = [
    "Up/Down movement not working",
    "hoist movement jam",
    "Hook/ Latch problem",
    "Cable broken/short circuit",
    "pendant broken",
    "Fan not working",
    "Rotation not working",
    "Jali/ Guard/ Blade broken",
    "Heavy Noise",
    "Smoke from Motor",
    "Temperature low",
    "Auto cycle not working",
    "Oil skimmer not working",
    "filter paper end",
    "Chip conveyor not working",
    "job cleaning not proper",
    "Heavy air leakge",
    "Heavy coolant leakage",
    "NG Burners/ heaters not working",
    "Hose pipe burst",
    "Loader/ unloader Not working",
    "sensor/Limit switch problem",
    "Rotary cage not working",
    "Job fall down or stucked in machine",
    "Gripper problem",
    "Teaching required",
    "Dashed on fixture ot machine",
    "Collision error",
    "Sensor not working",
    "Lubriation oil level low",
    "Entry conveyor / tiler problem",
    "Unloading conveyor/ tilter  problem",
    "Robot in fault",
    "Pr. Switch issue",
    "Cosmo Not working",
    "proxy/limit switch problem",
    "Hydr. Block cylinder leakage",
    "Hydraulic oil low",
    "Lub oil level low",
    "Pneumatic cylinder leakge",
    "Fixture / entry/ Exit conveyor not working",
    "Reading of test too high",
    "ATC not working",
    "APC not working",
    "Probe battery low",
    "Communication error",
    "Coolant leakage",
    "Oil Leakage",
    "BTS problem",
    "Tool Change not working",
    "filter paper end",
    "Hydraulic oil low",
    "Oilmatic unit temp.high",
    "Grease cartridge over",
    "Air leakakge",
    "Radiator cooling fan alarm",
    "Socket fallen",
    "Spindle alignment not proper",
    "Pusher/ Clamping problem",
    "Conveyor rotation/ up/down not working",
    "ASL up/ down not working",
    "Fault on controller",
    "Marking shift problem",
    "Marking not visible",
    "Conveyor not working",
    "Machine lamp not working",
    "GAP or pressing issue",
    "Conveyor not working",
    "Pusher and clamping issue",
    "Servo position for presssing not ok",
    "Hydraulic oil low",
    "Temp low/ high - heating problem",
    "IR tubes broken",
    "Reed switch/sensor/ limit switch issue",
    "heating chamber fans not working",
    "Conveyor not working",
    "Machine not working",
    "Hoist not working",
    "Electric short circuit",
    "overload trip",
    "Movement jam",
    "Conveyor not working",
    "Oil Leakage",
    "Coolant leakage",
    "Job fallen"
  ];
  List<String> machines = ['HD16',
    'HD07 ',
    'HD07 Pokayoke',
    'HD07 Q.Gate',
    'HD07 Conveyor ',
    'HD14',
    'HD14 TOD',
    'HD12',
    'HD12 Pokayoke',
    'HD13',
    'HD43',
    'HD15 ',
    'HD23',
    'HD23 Pokayoke',
    'HD47 ',
    'HD47 Conveyor',
    'HD08 TOD',
    'HD08',
    'HD11 ',
    'HD11 TOD',
    'Final Inspection',
    'HD45',
    'HD51',
    'HD114 Pokayoke',
    'HD114',
    'HD106 TOD',
    'HD106',
    'HD106 TOD',
    'HD106 Q  Gate',
    'HD109',
    'HD110 Pokayoke',
    'HD110 TOD',
    'HD121',
    'HD111',
    'HD112',
    'HD120',
    'HD113',
    'HD113A TOD',
    'HD107',
    'HD108',
    'HD108 TOD',
    'HD214 Pokayoke',
    'HD203',
    'HD204',
    'HD205',
    'HD221',
    'HD213',
    'HD206',
    'HD207',
    'Q Gate',
    'HD208',
    'HD209',
    'HD210',
    'HD212',
    'HD220',
    'HD211',
    'HD301',
    'HD302',
    'HD303',
    'HD305',
    'HD306',
    'HD307 ',
    'HD308',
    'HD309',
    'HD310',
    'HD311',
    'HD311 TOD',
    'Final TOD',
    'HD104 ',
    'HD201',
    'HD202',
    'HD102',
    'HD312',
    'HD313',
    'HD105',
    'HBL208',
    'HBL230',
    'HD401',
    'HD402',
    'HD403',
    'HD404',
    'HD304',
    'HD405',
    'HD406',
    'HH01',
    'HH02',
    'HH03',
    'HH04',
    'HH05',
    'HH06',
    'HH07',
    'HH08',
    'HH09',
    'HH10',
    'HH11',
    'HH12',
    'HH13',
    'HH14',
    'HH15',
    'HH16',
    'HH17',
    'HH18',
    'HH19',
    'HH20',
    'HH21',
    'HH22',
    'HH23',
    'HH24',
    'HH25',
    'HH26',
    'HH27',
    'HH28',
    'HH29',
    'HH30',
    'HH31',
    'HH32',
    'HH33',
    'HH34',
    'HH35',
    'HH36',
    'HH37',
    'HH38',
    'HH39',
    'HH40',
    'HH41',
    'HH42',
    'HH43',
    'HH44',
    'HH45',
    'HH46',
    'HH47',
    'HH48',
    'HH49',
    'HH50',
    'HH51',
    'HH52',
    'HH53',
    'HH54',
    'HH55',
    'HH56',
    'HH57',
    'HH58',
    'HH59',
    'HH60',
    'HH61',
    'HH62',
    'HH63',
    'HH64',
    'HH65',
    'F101',
    'F102',
    'F103',
    'F104',
    'F105',
    'F106',
    'F107',
    'F108',
    'F109',
    'F110',
    'F111',
    'F112',
    'F113',
    'F114',
    'F115',
    'F116',
    'F117',
    'F118',
    'F119',
    'F120',
    'F201',
    'F202',
    'F203',
    'F204',
    'F205',
    'F206',
    'F207',
    'F208',
    'F209',
    'F210',
    'F211',
    'F212',
    'F213',
    'F214',
    'F215',
    'F216',
    'F217',
    'F218',
    'F219',
    'F220',
    'F301',
    'F302',
    'F303',
    'F304',
    'F305',
    'F306',
    'F307',
    'F308',
    'F309',
    'F310',
    'F311',
    'F312',
    'F313',
    'F314',
    'F315',
    'F316',
    'F317',
    'F318',
    'F319',
    'F320',
    'F401',
    'F402',
    'F403',
    'F404',
    'F405',
    'F406',
    'F407',
    'F408',
    'F409',
    'F410',
    'F411',
    'F412',
    'F413',
    'F414',
    'F415',
    'F416',
    'F417',
    'F418',
    'F419',
    'F420',
    'F501',
    'F502',
    'F503',
    'F504',
    'F505',
    'F506',
    'F507',
    'F508',
    'F509',
    'F510',
    'F511',
    'F512',
    'F513',
    'F514',
    'F515',
    'F516',
    'F517',
    'F518',
    'F519',
    'F520',
  ];
  List<String> linetype = ["4SP Krauseco Cylinder Headline","4SP Makino Cylinder Headline","2.2L Cylinder Headline","5L Cylinder Headline","3l/3.3L Cylinder Headline","Hoists and Cranes","Mancooling Fan"];
  List<String> issuetype = ["Mechanical Issue", "Electrical Issue"];
  String lineNo="";
  String machineNo = "";
  String issue = "";
  AutoCompleteTextField searchTextField;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    type = '';
    lineNo='';
  }
  @override
  Widget build(BuildContext context) {
    print('addComplaint');

    print(widget.userDetails);
    return Scaffold(
      //backgroundColor: Color(0xFFE5E5E5),
      appBar: CustomAppBar(
        child: Text(
          'Raise a Complaint',
          style: titleText,
        ),
        elevation: false,
        backIcon: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  //text
                  DropdownButtonFormField(
                    // style: TextStyle(color: Color(0xFF1467B3)),
                    decoration: InputDecoration(
                      hintText: "Line No.",
                      hintStyle: TextStyle(
                          color: Color(0xFF1467B3), fontSize: 16),
                      filled: true,
                      fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                      contentPadding:
                      const EdgeInsets.only(
                          left: 14.0, bottom: 15.0, top: 15.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(93, 153, 252, 100)),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color.fromRGBO(
                              223, 232, 247, 100)) //dfe8f7
                      ),
                    ),
                    value: lineNo.isNotEmpty ? lineNo : null,
                    onSaved: (value) {
                      setState(() {
                        lineNo = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        lineNo = value;
                      });
                    },
                    items: linetype.map((item) {
                      return DropdownMenuItem<String>(
                          child: new Text(item), value: item);
                    }).toList(),
                    validator: (value) =>
                    value == null ? '' : null,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //machine no
                  Container(
                    height: 50,
                    child: AutoCompleteTextField<String>(
                      key: key2,
                      clearOnSubmit: false,
                      suggestions: machines,
                      //style: TextStyle(color: Colors.blue,fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Machine No.",
                        hintStyle: TextStyle(
                            color: Color(0xFF1467B3), fontSize: 16),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding:
                        const EdgeInsets.only(
                            left: 14.0, bottom: 15.0, top: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(93, 153, 252, 100)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                223, 232, 247, 100)) //dfe8f7
                        ),
                      ),
                      itemFilter: (item, query) {
                        return item.toLowerCase().startsWith(
                            query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.compareTo(b);
                      },
                      itemSubmitted: (item) {
                        setState(() {
                          machineNo = item.toString();
                          print(machineNo);
                          searchTextField.textField.controller.text = item;
                        });
                      },
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item, style: TextStyle(
                                fontSize: 18, color: Colors.black),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //issue
                  Container(
                    height: 50,
                    child: AutoCompleteTextField<String>(
                      key: key,
                      clearOnSubmit: false,
                      suggestions: suggestions,
                      //style: TextStyle(color: Colors.blue,fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Issue",
                        hintStyle: TextStyle(
                            color: Color(0xFF1467B3), fontSize: 16),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding:
                        const EdgeInsets.only(
                            left: 14.0, bottom: 15.0, top: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(93, 153, 252, 100)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                223, 232, 247, 100)) //dfe8f7
                        ),
                      ),
                      itemFilter: (item, query) {
                        return item.toLowerCase().startsWith(
                            query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.compareTo(b);
                      },
                      itemSubmitted: (item) {
                        setState(() {
                          issue = item.toString();
                          searchTextField.textField.controller.text = item;
                        });
                      },
                      itemBuilder: (context, item) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              item, style: TextStyle(
                                fontSize: 18, color: Colors.black),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
//                  SizedBox(
//                    height: 20,
//                  ),
//                  //type of issue
//                  Container(
//                    height: 50,
//                    child: AutoCompleteTextField<String>(
//                      key: key1,
//                      clearOnSubmit: false,
//                      suggestions: type,
//                      //style: TextStyle(color: Colors.blue,fontSize: 14),
//                      decoration: InputDecoration(
//                        hintText: "Type of Issue",
//                        hintStyle: TextStyle(
//                            color: Color(0xFF1467B3), fontSize: 16),
//                        filled: true,
//                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
//                        contentPadding:
//                        const EdgeInsets.only(
//                            left: 14.0, bottom: 15.0, top: 15.0),
//                        focusedBorder: OutlineInputBorder(
//                          borderSide: BorderSide(
//                              color: Color.fromRGBO(93, 153, 252, 100)),
//                        ),
//                        enabledBorder: OutlineInputBorder(
//                            borderSide: BorderSide(color: Color.fromRGBO(
//                                223, 232, 247, 100)) //dfe8f7
//                        ),
//                      ),
//                      itemFilter: (item, query) {
//                        return item.toLowerCase().startsWith(
//                            query.toLowerCase());
//                      },
//                      itemSorter: (a, b) {
//                        return a.compareTo(b);
//                      },
//                      itemSubmitted: (item) {
//                        setState(() {
//                          issueType = item.toString();
//                          searchTextField.textField.controller.text = item;
//                        });
//                      },
//                      itemBuilder: (context, item) {
//                        return Row(
//                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                          children: <Widget>[
//                            Text(
//                              item, style: TextStyle(
//                                fontSize: 18, color: Colors.black),
//                            ),
//                          ],
//                        );
//                      },
//                    ),
//                  ),
                  SizedBox(height: 20,),
                  DropdownButtonFormField(
                    // style: TextStyle(color: Color(0xFF1467B3)),
                    decoration: InputDecoration(
                        hintText: "Type of Issue",
                        hintStyle: TextStyle(
                            color: Color(0xFF1467B3), fontSize: 16),
                        filled: true,
                        fillColor: Color.fromRGBO(20, 103, 179, 0.05),
                        contentPadding:
                        const EdgeInsets.only(
                            left: 14.0, bottom: 15.0, top: 15.0),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(93, 153, 252, 100)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color.fromRGBO(
                                223, 232, 247, 100)) //dfe8f7
                        ),
                      ),
                    value: type.isNotEmpty ? type : null,
                    onSaved: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    items: issuetype.map((item) {
                      return DropdownMenuItem<String>(
                          child: new Text(item), value: item);
                    }).toList(),
                    validator: (value) =>
                    value == null ? '' : null,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //submit button
                  SizedBox(
                    width: 400,
                    height: 45,
                    child: FlatButton(
                      color: Color(0xFF1467B3),
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                      disabledTextColor: Colors.black,
                      padding: EdgeInsets.all(8.0),
                      splashColor: Colors.blueAccent,
                      onPressed: () async {

                        if(lineNo.isNotEmpty && machineNo.isNotEmpty && issue.isNotEmpty && issuetype.isNotEmpty) {
                          print("hoo" + widget.userDetails.uid);
                          await Firestore.instance.collection("binder")
                              .document(widget.userDetails.uid).collection(
                              "complaint")
                              .add(Complaint(
                              machineNo : machineNo,
                              department: "production",
                              issue: issue,
                              lineNo: lineNo,
                              startDate: DateTime.now().toString().substring(0, 10),
                              startTime: DateTime.now().toString().substring(11, 16),
                              assignedDate: '',
                              assignedTime: '',
                              endDate: '',
                              endTime: '',
                              verifiedDate: '',
                              verifiedTime: '',
                              assignedTo: null,
                              raisedBy: widget.userDetails.name,
                              mobileNo : widget.userDetails.mobileNo,
                              assignedBy: "",
                              status: 'notsolved'
                                ).toJson());
                        }
                        return Alert(
                          context: context,
                          type: AlertType.success,
                          title: "Complaint Raised!",
                          buttons: [
                            DialogButton(
                                child: Text(
                                  "Okay",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: (){ Navigator.pop(context);},
                              color: Color(0xFF1467B3),
                            ),
                          ],
                        ).show();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(fontSize: 15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}