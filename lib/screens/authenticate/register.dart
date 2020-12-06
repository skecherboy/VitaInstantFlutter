import 'package:flutter/material.dart';
import 'package:vita_instant/globalFunc/loading.dart';
import 'package:vita_instant/services/auth.dart';
import 'package:vita_instant/globalFunc/constants.dart';
class Register extends StatefulWidget {

  // Toggle widget
  final Function toggleView; 
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}
///////////////////////////////////////////////////////
///THIS IS THE ACTUAL STUFF ON THE SCREEN
//////////////////////////////////////////////////////
class _RegisterState extends State<Register> {

  // Final Unchanged Services etc..
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();  
  bool loading = false;
  //Email and Password States 
  String email = '';
  String password = '';
  String error = '';
///////////////////////////////////////////
///
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign Up to VitaInstant'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person), 
            label: Text('Sign In'),
            onPressed: () {
              widget.toggleView();
            },
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formkey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20.0), // Spacing
              
              //EMAIL FORM
              TextFormField( 
                decoration: textInputDecor.copyWith(hintText: 'Email'),
                validator:(val) => val.isEmpty ? 'Enter an Email': null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),

              //Password form
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'Password'),
                obscureText: true, 
                validator:(val) => val.length<6 ? 'Enter a password 6 chars long': null,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),// spacing

              // Logout button
              RaisedButton(
                color: Colors.red[400],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                // CHECK FOR VALIDATION UPON PRESS OF BUTTON
                onPressed: () async{
                  if(_formkey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {error = 'Please Use Valid Email';
                      loading = false; 
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.black, fontSize: 14.0 ),
              )
            ],
          )
        )
      ),
    );
  }
}