// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyB7irVhXHUUSuePovvgPI6r2K4ZtSsWtxM',
    appId: '1:751846764681:web:9580eae8e56d4b9622d658',
    messagingSenderId: '751846764681',
    projectId: 'e-commerce-app-1f6c5',
    authDomain: 'e-commerce-app-1f6c5.firebaseapp.com',
    storageBucket: 'e-commerce-app-1f6c5.appspot.com',
    measurementId: 'G-XN9GDWBTJ5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAXnePA7EpApdeIBmLmHVPFcPsWFQh3N_4',
    appId: '1:751846764681:android:b7f4f5c6ec81eb6a22d658',
    messagingSenderId: '751846764681',
    projectId: 'e-commerce-app-1f6c5',
    storageBucket: 'e-commerce-app-1f6c5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHOFrVh-pHdhC77rxeJ2qYmaIcwofubiM',
    appId: '1:751846764681:ios:921524de2b6897a322d658',
    messagingSenderId: '751846764681',
    projectId: 'e-commerce-app-1f6c5',
    storageBucket: 'e-commerce-app-1f6c5.appspot.com',
    iosBundleId: 'com.example.tStore',
  );
}