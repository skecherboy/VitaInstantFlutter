import 'package:cloud_firestore/cloud_firestore.dart';

class UserMeds {
   String meds;
   String instruction;
   String important;
   String dosage;
   
   DateTime fillDate;
   DateTime expire;

   String rxNum;
   int qty;
   String refills;

   String docID;
   
 
  

  UserMeds({
            this.meds, this.instruction, this.important, this.dosage, 
            this.rxNum, this.qty, this.refills, this.fillDate, 
            this.expire, 
            }
            );

// INSERT JSON MODEL HERE
Map<String, dynamic> toJson() => {
  'meds':meds,
  'dosage':dosage,
  'instruction': instruction,
  'important':important,
  'rxNum':rxNum,
  'qty':qty,
  'refills':refills,
  'fillDate':fillDate,
  'expire':expire,
}; 



UserMeds.fromSnapshot(DocumentSnapshot snap):
docID = snap.documentID;  
}



