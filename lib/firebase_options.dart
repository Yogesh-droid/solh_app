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
    apiKey: 'AIzaSyBwI02bU60dkDODYLTd5TThwNM_0VnVFnc',
    appId: '1:729100578162:web:5f531c6f2ef71a9516c1eb',
    messagingSenderId: '729100578162',
    projectId: 'solh-flutter',
    authDomain: 'solh-flutter.firebaseapp.com',
    storageBucket: 'solh-flutter.appspot.com',
    measurementId: 'G-33DTS23X7F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpu9w_iT-DTIq9MkelRwbRCR_eS8kBuCY',
    appId: '1:729100578162:android:e05f9666d863470216c1eb',
    messagingSenderId: '729100578162',
    projectId: 'solh-flutter',
    storageBucket: 'solh-flutter.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCGv_CUh8pcefc8fpFJkr9y--x9A4D7Agk',
    appId: '1:729100578162:ios:8bba3add7e1c3d4616c1eb',
    messagingSenderId: '729100578162',
    projectId: 'solh-flutter',
    storageBucket: 'solh-flutter.appspot.com',
    androidClientId: '729100578162-3234f20jbagovh1oof2pes65k831r712.apps.googleusercontent.com',
    iosClientId: '729100578162-kdom05efa8vikelg837r07bt555kt1qd.apps.googleusercontent.com',
    iosBundleId: 'com.solh.solhApp',
  );
}
