import  'package:flutter/material.dart';
import 'package:vita_instant/globalFunc/loading.dart';
import 'package:vita_instant/services/auth.dart';
import 'package:vita_instant/globalFunc/constants.dart';

class SignIn  extends StatefulWidget {

   final Function toggleView; 
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}
/////////////////////////////////////////
///ACTUAL STUFF IN THE SCREEN
/////////////////////////////////////////

class _SignInState extends State<SignIn> {
  
  //Variables, States, Bools Etc...
  final AuthService _auth = AuthService();  
  final _formkey = GlobalKey<FormState>();  
  bool loading = false;

  // Email and Pass States
  String email = '';
  String password = '';
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        elevation: 0.0,
        title: Text('Sign In to VitaInstant'),
        actions: <Widget>[
          FlatButton.icon(
          icon:  Icon(Icons.person),
          label: Text('Register'),
          onPressed: () {
            widget.toggleView();
          }
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
              
              //EMAIL SECTION
              TextFormField( 
                decoration: textInputDecor.copyWith(hintText: 'Email'),
                validator:(val) => val.isEmpty ? 'Enter an Email': null,
                onChanged: (val){
                  setState(() => email = val);
                }
              ),

              //PASSWORD SECTION
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

              // LOGOUT BUTTON
              RaisedButton(
                color: Colors.red[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  // Checks for validation of the text in da box (ir er)
                  if(_formkey.currentState.validate()){
                      setState(() => loading = true );
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        error = 'Credentials Failed: Could Not Sign In';
                        loading = false;
                    });
                  }
                }
              }
            ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.black, fontSize: 14.0 ),
              ),
            ],
          )
        )
      ),
    );
  }
} 