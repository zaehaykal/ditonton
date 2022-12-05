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
    apiKey: 'AIzaSyBe5Mqc4_1St-eo8zg4gNcQU_9rx3t94xE',
    appId: '1:1014775196071:web:7c876ca5d37c1fbfd52e82',
    messagingSenderId: '1014775196071',
    projectId: 'ditonton-ec623',
    authDomain: 'ditonton-ec623.firebaseapp.com',
    storageBucket: 'ditonton-ec623.appspot.com',
    measurementId: 'G-Y8BHSTMPKK',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCW-1H5ckKL6iWxDuNet8SmW6Iko8924SU',
    appId : '1:297694470933:android:aaa9821708a597c5d8bf1c',
    // appId: '1:1014775196071:android:55c9ba9d5bf8c17cd52e82',
    messagingSenderId: '1014775196071',
    projectId: 'ditonton-ec623',
    storageBucket: 'ditonton-ec623.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDc6nFRX8OMSdx9yVctBhz5Ak3Ic2mIAy8',
    // appId: '1:1014775196071:ios:fab1d1ac59737bbfd52e82',
    appId : '1:297694470933:ios:49b4b12ded639f75d8bf1c',
    messagingSenderId: '1014775196071',
    projectId: 'ditonton-ec623',
    storageBucket: 'ditonton-ec623.appspot.com',
    iosClientId:
        '1014775196071-g2h4o57pdaj71con0mpgnrod2b0a4prs.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
