import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:souncloud_clone/firebase_options.dart';
import 'package:souncloud_clone/screens/wrapper.dart';
import 'package:souncloud_clone/services/auth.dart';
import 'package:souncloud_clone/util/navbar.dart';
import 'package:souncloud_clone/screens/authenticate/sign_in.dart';
import 'package:souncloud_clone/screens/authenticate/sign_up.dart';
import 'package:souncloud_clone/screens/splash.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthencationService().user,
      initialData: null,
      catchError: (context, error) => null,
      child: MaterialApp(
        routes: {
          '/signup': (context) => SignupPage(),
          '/signin': (context) => LoginPage(),
          '/home': (context) => CustomNavBar(),
          '/wrapper': (context) => Wrapper(),
        },
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
