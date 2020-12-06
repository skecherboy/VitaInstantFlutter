import 'package:flutter/material.dart';
import 'package:vita_instant/models/med_model.dart';
import 'package:vita_instant/screens/home/new_med_form_two.dart';
class NewMedForm extends StatelessWidget {
  final UserMeds medsNew;
  NewMedForm({this.medsNew});

  @override
  Widget build(BuildContext context) {
    TextEditingController _medController = new TextEditingController();
    TextEditingController _instructController = new TextEditingController();
    TextEditingController _cautionController = new TextEditingController();

    _medController.text = medsNew.meds;
    _instructController.text = medsNew.instruction;
    _cautionController.text = medsNew.important;


    return Scaffold(
      appBar: AppBar(title: Text('Create New Medication and Dosage'),
      ),
      body: Center(
        child: Column(

          children: <Widget>[

          Text('Enter a Medication'),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child:TextField(controller:_medController ,
                          autofocus: true,
                          ),
                        ),
 
        
          Text('Enter Instructions'),
          Padding(padding: const EdgeInsets.all(10.0),
          child:TextField(controller: _instructController,
                          autofocus: true,)
                    ),
        
          Text('Enter Warning/Caution info'),
          Padding(padding: const EdgeInsets.all(10.0),
          child:TextField(controller: _cautionController,
                          autofocus: true,)
                    ),
        
          RaisedButton(
            child:Text('Continue'),
            onPressed: ()
              {
                medsNew.meds = _medController.text;
                medsNew.instruction = _instructController.text;
                medsNew.important = _cautionController.text;
                Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> NewMedFormTwo(medsNew: medsNew)
                    ),
                  );
              },
            ),  
          ],

        ),
      )
    );
  }
}