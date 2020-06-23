import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_binder/models/user_data.dart';
import 'package:final_binder/services/auth.dart';

class DatabaseServices{
  final String uid;

  //creating db instance for binder collection
  final AuthService auth = AuthService();

  DatabaseServices({this.uid});
  CollectionReference collectionReference = Firestore.instance.collection("user_details");

  Future initiateDocument() async{
    return await Firestore.instance.collection("user_details").document(uid).setData({});
  }

  Future updateUserData(UserDetails userDetails) async{
    return await Firestore.instance.collection("user_details").document(uid).collection(uid).document(uid).setData(userDetails.toJson());
  }

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
    return Firestore.instance.collection("user_details").document(uid)
        .snapshots().map(userDetailsFromSnapshot);
  }
}