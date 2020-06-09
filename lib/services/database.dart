import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user_data.dart';

class DatabaseServices{

  final String uid;
  DatabaseServices({this.uid});

  //creating db instance for binder collection
  final CollectionReference db = Firestore.instance.collection("binder");

  Future updateComplaintData(UserDetails details) async{
    return await db.document(uid).collection("complaint").add(details.toJson());
  }

}