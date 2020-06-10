import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';
import 'package:provider/provider.dart';

class DatabaseServices{
  final String uid;

  //creating db instance for binder collection
  final CollectionReference collectionReference = Firestore.instance.collection("binder");
  final AuthService auth = AuthService();

  DatabaseServices({this.uid});

//  Future updateUserData(UserDetails detail, String uid) async{
//    return await db.document(uid).collection("user_details").add({
//      'name': detail.name,
//      'designation': detail.designation,
//      'mobile_no': detail.mobileNo,
//      'bay_no': detail.bay_no,
//    });
//  }

  UserDetails userDetailsFromSnapshot(DocumentSnapshot snapshot){
    return UserDetails(
      uid : uid,
      name : snapshot.data['name'],
      authLevel : snapshot.data['designation'],
      mobileNo: snapshot.data['mobile_no'],
      bayNo : snapshot.data['bay_no'],
    );
  }

  Stream<UserDetails> get userDetails{
    return collectionReference.document(uid).collection("user_details").document(uid)
        .snapshots().map(userDetailsFromSnapshot);
  }

}