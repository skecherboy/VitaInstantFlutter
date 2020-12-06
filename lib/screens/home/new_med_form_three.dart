import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vita_instant/models/med_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMedFormThree extends StatelessWidget {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserMeds medsNew;
  NewMedFormThree({this.medsNew});

  @override
  Widget build(BuildContext context) {
    TextEditingController _rxNumController = new TextEditingController();
    TextEditingController _refillController = new TextEditingController();
    TextEditingController _qtyController = new TextEditingController();
    _rxNumController.text = medsNew.rxNum;
    _refillController.text = medsNew.refills;

    return Scaffold(
      appBar: AppBar(title: Text('Create New Medication'),
      ),
      body: Center(
        child: Column(

          children: <Widget>[
          Text('Enter RX Number'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:TextField(controller:_rxNumController ,
                          autofocus: true,
                          ),
                        ),
          
        


          Text('Enter Amount of Refills'),
          Padding(padding: const EdgeInsets.all(10.0),
          child:TextField(controller: _refillController,
                          autofocus: true,)
                    ),
        
          Text('Enter Pill Quantity'),
          Padding(padding: const EdgeInsets.all(10.0),
          child:TextField(controller: _qtyController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
          ),


          RaisedButton(
            child:Text('Finish'),
            onPressed: () async
              {
                 if (_qtyController.text.trim() != '' )
                 {
                 int qty = int.parse(_qtyController.text.trim());
                 medsNew.qty = qty;
                 }
                 medsNew.rxNum = _rxNumController.text;
                 medsNew.refills = _refillController.text;
                final _user = await _auth.currentUser();
                var uid = _user.uid;
                print(uid);
                await db.collection('UserData').document(uid).collection('meds').add(medsNew.toJson());   
                medsNew.docID = db.collection('UserData').document(uid).collection('meds').document().documentID.toString();             
                Navigator.of(context).popUntil((route)=>route.isFirst);
              },
            ),  
          ],

        ),
      )
    );
  }
}
