import 'package:flutter/material.dart';
import 'package:souncloud_clone/screens/authenticate/sign_in.dart';
import 'package:souncloud_clone/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      // return SignIn(onSuccessfulSignIn: toggleView);
      return LoginPage(toggleView: toggleView);
    } else {
      // return Register(onSuccessfulRegister: toggleView);
      return SignupPage(toggleView: toggleView);
    }
  }
}
