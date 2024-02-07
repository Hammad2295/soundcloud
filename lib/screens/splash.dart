import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, '/wrapper');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 70, 13),
      body: Center(
        child: Container(
          // color: Color.fromARGB(255, 195, 98, 28),
          width: MediaQuery.of(context).size.width *
              0.3, // Adjust the width as needed
          height: MediaQuery.of(context).size.height *
              0.2, // Adjust the height as needed
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/soundcloud2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
