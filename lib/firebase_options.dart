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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBeea-o5nSGV-g693TMynQCbMX3PzevgIo',
    appId: '1:1041526288855:android:09afb05ac4da2cafe31b92',
    messagingSenderId: '1041526288855',
    projectId: 'patrimony-f51f9',
    storageBucket: 'patrimony-f51f9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbbh2-uFs2GF7kB6l0wG6mGowE-Fpfdfw',
    appId: '1:1041526288855:ios:82705b04e7e3e772e31b92',
    messagingSenderId: '1041526288855',
    projectId: 'patrimony-f51f9',
    storageBucket: 'patrimony-f51f9.appspot.com',
    androidClientId: '1041526288855-i4ihl03cgoe9rp9i32q9ipfe9t4p5q2u.apps.googleusercontent.com',
    iosClientId: '1041526288855-lvubbob7d45irp60qdlpp5kobu4g750d.apps.googleusercontent.com',
    iosBundleId: 'com.sodremr.patrimony',
  );
}
