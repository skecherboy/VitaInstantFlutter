import 'package:cloud_firestore/cloud_firestore.dart';

class BoolMod{
  int boolInput;
  String boolDocId;

  BoolMod({this.boolInput});


  Map<String, dynamic> toJson() => {
  'boolInput': boolInput
}; 

  BoolMod.fromSnapshot(DocumentSnapshot snapshot):
  boolDocId = snapshot.documentID;


}