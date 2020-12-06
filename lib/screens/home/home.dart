import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vita_instant/screens/home/new_med_form.dart';
import 'package:vita_instant/models/med_model.dart';
import 'package:vita_instant/models/bool_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';   
import 'package:intl/intl.dart';


class Home extends StatelessWidget {
  final db = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final newMed = new UserMeds();
  final boolInt = new BoolMod();
  final title = 'VitaInstant';

  static var baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
    );
  static var  regularTextStyle = baseTextStyle.copyWith(
      //color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
    );
  final headerTextStyle = baseTextStyle.copyWith(
      fontSize: 24.0,
      fontWeight: FontWeight.w600
    );

  final subHeaderTextStyle = regularTextStyle.copyWith(
      fontSize: 16.0,
      fontWeight: FontWeight.w500

    );


  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: title,
      home:Scaffold(
        backgroundColor: Colors.grey[100],
        body:CustomScrollView(
  slivers: <Widget>[
    SliverAppBar(
              title: Text(title),
              titleSpacing: 1.5,
              floating: true,
              expandedHeight: 75,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.add_circle),
                  label:Text('Med'),
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> NewMedForm(medsNew: newMed)
                    ),
                  );
                  },
                  ),

                  FlatButton.icon(  
                    icon: Icon(Icons.donut_small),
                    label: Text('Dispense'),
                    textColor: Colors.white,
                    onPressed:()
                    async{
                        updateBool(context);
                    }
                  ),


                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Logout'), 
                    textColor: Colors.white,
                    onPressed: () async{
                    await _auth.signOut();

              },
                  ),
                  
                ],
              ),
    StreamBuilder(
      stream: getUsersMedsStreamSnapshots(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SliverPadding(
            padding: const EdgeInsets.all(5.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  DocumentSnapshot ds = snapshot.data.documents[index];
                  final med = ds['meds'];
                  final instruction = ds['instruction'];
                  final important = ds['important'];
                  final qty = ds['qty'];
                  final refill =ds['refills'];
                  final fillDate = ds['fillDate'];
                  final expire = ds['expire'];
                return new InkWell(
                  onLongPress: () async{
                    print(snapshot.data.documents[index]);
                    var newDs = UserMeds();
                    // newDs.meds = ds['meds'];
                    // newDs.instruction = ds['instruction'];
                    // newDs.important = ds['important'];
                    // newDs.qty = ds['qty'];
                    // newDs.refills =ds['refills'];
                    // //newDs.fillDate = ds['fillDate'];
                    // //newDs.expire = ds['expire'];
                    newDs.docID = ds.documentID;
                    await deleteMed(newDs);
                  },
                  child: new Card(
                    //textDirection: TextDirection.ltr,
                    margin: new EdgeInsets.fromLTRB(4, 10.0, 4, 10.0),
                    //color: Colors.blueGrey,
                    child:Column(
                      mainAxisSize: MainAxisSize.max, 
                      children:<Widget>[
                      
                      new Container(height: 4),
                      new Text('Medication: $med ',
                      style:  headerTextStyle),
                      
                      new Container(height: 8),
                      new Text('Instruction: $instruction',
                      style: subHeaderTextStyle),

                      new Container(height: 10),
                      new Text('Important: $important',
                      style: subHeaderTextStyle),

                      new Container(height: 12),
                      new Container(width: 2),
                      new Text('QTY: $qty'.toString()),

                      new Container(height: 14),
                      new Text('Refill #: $refill'),

                      new Container(height: 16),
                      new Text("Fill Date: ${DateFormat('dd/MM/yyyy').format(fillDate.toDate()).toString()}"),

                      new Container(height: 18),
                      new Text("Expiration Date: ${DateFormat('dd/MM/yyyy').format(expire.toDate()).toString()}"),


                    ],
                    )
                      )
                );
                  },
                  childCount: snapshot.data.documents.length,
                ),
              ),
            );
          } 
        else {
          return SliverFillRemaining(
            child: Center(
              child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    ],
    )
  ),
  );
}
  


  Stream<QuerySnapshot> getUsersMedsStreamSnapshots(BuildContext context) async* {
    
    final _user = await _auth.currentUser();
    var uid = _user.uid;
    yield* Firestore.instance.collection('UserData').document(uid).collection('meds').snapshots();
  }



  Future updateBool(context) async{
                    final _userPing = await _auth.currentUser();
                    var pingUid = _userPing.uid;
                    boolInt.boolInput = 1;
                    final dbBool = Firestore.instance
                    .collection('UserData').
                    document(pingUid).
                    collection('boolState').
                    document('93OQNYSqsxGUTLIISaeX');
                    return await dbBool.setData(boolInt.toJson());
                    }
                  


Future deleteMed(context) async{
                    final _userPing = await _auth.currentUser();
                    var pingUid = _userPing.uid;

                    final medDb = Firestore.instance
                    .collection('UserData').
                    document(pingUid).
                    collection('meds').
                    document(context.docID);      
                    
                    return await medDb.delete();
                    }
}





/////////////////////////////////////////////////////////////////////
///
/// DEAD CODE ZONE - DEAD CODE ZONE - DEAD CODE ZONE - DEAD CODE ZONE
///
/////////////////////////////////////////////////////////////////////



// Widget streamer(BuildContext: context){

//   return StreamBuilder(
//               stream:getUsersTripsStreamSnapshots(context) ,
//               builder: (context,snapshot){
//                 if(!snapshot.hasData) return const Text("Loading...");
//               return new ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               itemBuilder: (BuildContext context, int index) =>
//                   buildTripCard(context, snapshot.data.documents[index]));
//               }
//           );
// }

//   Widget buildTripCard(BuildContext context, DocumentSnapshot med) {
//     return new Container(
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
//                 child: Row(children: <Widget>[
//                   Text(med['meds'], style: new TextStyle(fontSize: 30.0),),
//                   Spacer(),
//                 ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
//                 child: Row(children: <Widget>[
//                   Text(
//                       "${DateFormat('dd/MM/yyyy').format(med['fillDate'].toDate()).toString()} - ${DateFormat('dd/MM/yyyy').format(med['expire'].toDate()).toString()}"),
//                   Spacer(),
//                 ]),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
//                 child: Row(
//                   children: <Widget>[
//                     Text("${(med['instruction'] == null)? "n/a" : med['instruction'].toString()}", style: new TextStyle(fontSize: 35.0),),
//                     Spacer(),
//                     Icon(Icons.directions_car),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
  
// class Home extends StatelessWidget {

//   final AuthService _auth = AuthService();
//   @override
//   Widget build(BuildContext context) {
    
//     final newMed = new UserMeds();

//   // Private Setting Panel function
//     void _showSettingsPanel(){
//       showModalBottomSheet(context:context, builder: (context){
//         // Widget Tree to describe whats inside the button panel after being pressed
//       return Container(
//         padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//         child:Text('Bottom sheet'),
//       );
//       });
//     }

// //////////////////////////////////////////////////////////////

// //     return StreamProvider<List<UserData>>.value(
// //         value: DatabaseService().userData,
// //         child: Scaffold(
// //         backgroundColor: Colors.grey[200],
// //         appBar: AppBar(
// //           title: Text('VitaInstant Home'),
// //           backgroundColor: Colors.blue[500],
// //           elevation: 0.0,
          
// //           // BUTTONS AND THEIR ACTIONS
// //           actions: <Widget>[
// //             FlatButton.icon(
// //               icon: Icon(Icons.person),
// //               label: Text('Logout'),
// //               onPressed: () async{
// //                 await _auth.signOut();

// //               },
// //             ),
// //             FlatButton.icon(
// //               icon: Icon(Icons.settings), 
// //               label:Text(''),
// //               onPressed: () => _showSettingsPanel()
              
// //               ),
// //             FlatButton.icon(
// //               icon: Icon(Icons.add),
// //               label: Text(''),
// //               onPressed: (){
// //                 Navigator.push(context, 
// //                     MaterialPageRoute(builder: (context)=> NewMedForm(medsNew: newMed)
// //                     ),
// //                   );
// //               },
// //             )
// //           ],
// //         ),
        
// //         //body: UserList()
// //       ),
// //     );
// //   }
// // }

// Widget build(BuildContext context) {
  //   return Container(
  //     child: StreamBuilder(
  //       stream: getUsersTripsStreamSnapshots(context), 
  //       builder: (context, snapshot) {
  //         if(!snapshot.hasData) return const Text("Loading...");
  //         return new ListView.builder(
  //             itemCount: snapshot.data.documents.length,
  //             itemBuilder: (BuildContext context, int index) =>
  //                 buildTripCard(context, snapshot.data.documents[index]));
  //       }
  //     ),
  //   );
  // }

// return StreamProvider<QuerySnapshot>.value(
    //   value:  getUsersTripsStreamSnapshots(context),
    //   child: Scaffold(
    //     backgroundColor: Colors.grey[200],
    //     appBar: AppBar(
    //       title: Text('VitaInstant Home'),
    //       backgroundColor: Colors.blue[500],
    //       elevation: 0.0,
          
    //       // BUTTONS AND THEIR ACTIONS
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('Logout'),
    //           onPressed: () async{
    //             await _auth.signOut();

    //           },
    //         ),
    //         // FlatButton.icon(
    //         //   icon: Icon(Icons.settings), 
    //         //   label:Text(''),
    //         //   onPressed: () => _showSettingsPanel()
              
    //         //   ),
    //         FlatButton.icon(
    //           icon: Icon(Icons.add),
    //           label: Text(''),
    //           onPressed: (){
    //             Navigator.push(context, 
    //                 MaterialPageRoute(builder: (context)=> NewMedForm(medsNew: newMed)
    //                 ),
    //               );
    //           },
    //         ),
            
    //       ],
    //     ),
    //   ),
      
    // );