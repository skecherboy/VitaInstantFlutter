import 'package:flutter/material.dart';
import 'package:vita_instant/models/med_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:date_range_picker/date_range_picker.dart' as DatePicker;
import 'package:vita_instant/screens/home/new_med_form_three.dart';


class NewMedFormTwo extends StatefulWidget {
  final UserMeds medsNew;
  NewMedFormTwo({this.medsNew});

  @override
  _NewMedFormTwoState createState() => _NewMedFormTwoState();
}
//////////////////////////////////////////////////////////////////
///
//////////////////////////////////////////////////////////////////

class _NewMedFormTwoState extends State<NewMedFormTwo> {
  DateTime _fillDate = DateTime.now();
  DateTime _expireDate = DateTime.now().add(Duration(days:7));

  Future displayDateRangePicker(BuildContext context) async{
    final List<DateTime> picked = await DatePicker.showDatePicker(
      context:context, 
      initialFirstDate: _fillDate,
      initialLastDate:  _expireDate,
      firstDate: new DateTime(DateTime.now().year - 50),
      lastDate:  new DateTime(DateTime.now().year + 50)
      );
      if (picked != null && picked.length ==2){
        setState(() {
          _fillDate   = picked[0];
          _expireDate = picked[1];
        });
      }
  }

  @override
  Widget build(BuildContext context) {

    TextEditingController _rxNumController = new TextEditingController();
    _rxNumController.text = widget.medsNew.rxNum;

    return Scaffold(
      appBar: AppBar(title: Text('Create New Medication'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
          RaisedButton(
            child: Text('Select Fill & Expiration Dates'),
            onPressed: () async {
              await displayDateRangePicker(context);
            },
          ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('Fill Date: ${DateFormat('MM/dd/yyyy').format(_fillDate).toString()}'),
              Text('Expiration Date:${DateFormat('MM/dd/yyyy').format(_expireDate).toString()}')
            ],
            ),
        
        
          RaisedButton(
            child:Text('Continue'),
            onPressed: (){
              widget.medsNew.fillDate = _fillDate;
              widget.medsNew.expire = _expireDate;
          
              Navigator.push(context, 
                    MaterialPageRoute(builder: (context)=> NewMedFormThree(medsNew: widget.medsNew)
                    ),
                  );
            }
            ),  
          ],

        ),
      )
    );
  }
}