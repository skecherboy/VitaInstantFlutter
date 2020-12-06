//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vita_instant/models/user.dart';
import 'package:vita_instant/screens/home/home.dart';
import 'package:vita_instant/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);
    print(user);

    // return home or authenticate widget
    if (user == null){
    return Authenticate();
    }
    else{
      return Home();
    }
    }
} 