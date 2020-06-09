import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:provider/provider.dart';

class DatabaseServices{

  //creating db instance for binder collection
  final CollectionReference collectionReference = Firestore.instance.collection("binder");
  final AuthService auth = AuthService();

//  Future updateUserData(UserDetails detail, String uid) async{
//    return await db.document(uid).collection("user_details").add({
//      'name': detail.name,
//      'designation': detail.designation,
//      'mobile_no': detail.mobileNo,
//      'bay_no': detail.bay_no,
//    });
//  }

}