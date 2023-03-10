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
        return macos;
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
    apiKey: 'AIzaSyAGiL4hH0Ftp_a9gM1F3C78Cxu6_rb-3Os',
    appId: '1:732768197454:web:e0255e8527cdde8fb5dc1f',
    messagingSenderId: '732768197454',
    projectId: 'sportlink-45001',
    authDomain: 'sportlink-45001.firebaseapp.com',
    storageBucket: 'sportlink-45001.appspot.com',
    measurementId: 'G-8QPPW3Z9M9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAgWIPpHsoZdP_Ap4W4idhW6B1P0X6k52M',
    appId: '1:732768197454:android:0dab5bf6b0c37502b5dc1f',
    messagingSenderId: '732768197454',
    projectId: 'sportlink-45001',
    storageBucket: 'sportlink-45001.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAp7nwxVr6Iz7WXK_pCLj-Y1Ud4VvkJwqg',
    appId: '1:732768197454:ios:5896ec1b8259b9f6b5dc1f',
    messagingSenderId: '732768197454',
    projectId: 'sportlink-45001',
    storageBucket: 'sportlink-45001.appspot.com',
    iosClientId: '732768197454-de53k5ukto9n9dmfi3i1t4jlmn8dlqai.apps.googleusercontent.com',
    iosBundleId: 'com.example.sportlink',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAp7nwxVr6Iz7WXK_pCLj-Y1Ud4VvkJwqg',
    appId: '1:732768197454:ios:5896ec1b8259b9f6b5dc1f',
    messagingSenderId: '732768197454',
    projectId: 'sportlink-45001',
    storageBucket: 'sportlink-45001.appspot.com',
    iosClientId: '732768197454-de53k5ukto9n9dmfi3i1t4jlmn8dlqai.apps.googleusercontent.com',
    iosBundleId: 'com.example.sportlink',
  );
}
