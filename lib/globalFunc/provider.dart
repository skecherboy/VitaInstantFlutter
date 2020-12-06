import 'package:provider/provider.dart';
import 'package:vita_instant/services/auth.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final AuthService auth;

  Provider ({this.auth});
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType() as Provider);
}