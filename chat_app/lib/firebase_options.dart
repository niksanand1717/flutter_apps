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
    apiKey: 'AIzaSyDtjCo5gBs5_93eDd_eWy6prdIv43Kikf4',
    appId: '1:99148945212:web:e6964e38499ceef3063039',
    messagingSenderId: '99148945212',
    projectId: 'flutter-chat-app-61888',
    authDomain: 'flutter-chat-app-61888.firebaseapp.com',
    storageBucket: 'flutter-chat-app-61888.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBBjLMgTOq6KiMMvXqKim7Witym4S7TUR4',
    appId: '1:99148945212:android:e90cc5b822068b11063039',
    messagingSenderId: '99148945212',
    projectId: 'flutter-chat-app-61888',
    storageBucket: 'flutter-chat-app-61888.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB762uJ-sD5YFjdUsu-RSXkDJXDTPn7kaE',
    appId: '1:99148945212:ios:98451f695c702210063039',
    messagingSenderId: '99148945212',
    projectId: 'flutter-chat-app-61888',
    storageBucket: 'flutter-chat-app-61888.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );
}
