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
    apiKey: 'AIzaSyCybbQNk_6LDHq673WZfNTqkp-1aPn4-Ig',
    appId: '1:381188892888:web:e7673f3c2a556d6fa0cfad',
    messagingSenderId: '381188892888',
    projectId: 'moviedb-145d6',
    authDomain: 'moviedb-145d6.firebaseapp.com',
    storageBucket: 'moviedb-145d6.appspot.com',
    measurementId: 'G-RLCWP1LC5N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyArszXptuHLII7DiulazXuXkXBybUMhtWA',
    appId: '1:381188892888:android:a60188832026ba04a0cfad',
    messagingSenderId: '381188892888',
    projectId: 'moviedb-145d6',
    storageBucket: 'moviedb-145d6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtoGWkYGFG79SKQDpRWF2aRBBd3TVoQqo',
    appId: '1:381188892888:ios:182bae19c569bc1ea0cfad',
    messagingSenderId: '381188892888',
    projectId: 'moviedb-145d6',
    storageBucket: 'moviedb-145d6.appspot.com',
    iosClientId: '381188892888-7opggv2pc416e99m0qek2vv1qfme8gsd.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviedb',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAtoGWkYGFG79SKQDpRWF2aRBBd3TVoQqo',
    appId: '1:381188892888:ios:182bae19c569bc1ea0cfad',
    messagingSenderId: '381188892888',
    projectId: 'moviedb-145d6',
    storageBucket: 'moviedb-145d6.appspot.com',
    iosClientId: '381188892888-7opggv2pc416e99m0qek2vv1qfme8gsd.apps.googleusercontent.com',
    iosBundleId: 'com.example.moviedb',
  );
}