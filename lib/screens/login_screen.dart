import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LogInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: (val) {},
      onSignup: (val) {},
      onRecoverPassword: (val) {},
      theme: LoginTheme(
        primaryColor: Theme.of(context).primaryColor,
        accentColor: Colors.deepOrange[300],
      ),
    );
  }
}
