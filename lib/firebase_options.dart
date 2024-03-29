// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBrrfLtWWLJlTTKQHN0pBnY1XEFoPHrrs4',
    appId: '1:823716382268:web:6aeace9361fd895c78a539',
    messagingSenderId: '823716382268',
    projectId: 'first-app-26fd8',
    authDomain: 'first-app-26fd8.firebaseapp.com',
    storageBucket: 'first-app-26fd8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCcPSS8w2OaSvX6ncpoUioaqgwv2U3kdMA',
    appId: '1:823716382268:android:8d8990de13526b6678a539',
    messagingSenderId: '823716382268',
    projectId: 'first-app-26fd8',
    storageBucket: 'first-app-26fd8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwFiebmpDvzRUGGO6SYJmdV8-xAgfFzno',
    appId: '1:823716382268:ios:5c8121cdd2556bbc78a539',
    messagingSenderId: '823716382268',
    projectId: 'first-app-26fd8',
    storageBucket: 'first-app-26fd8.appspot.com',
    iosClientId: '823716382268-dsor30gc7k9tmjc68or4lo7e5bkajd9j.apps.googleusercontent.com',
    iosBundleId: 'com.example.souncloudClone',
  );
}
