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
    apiKey: 'AIzaSyCs1e9y9MzlIpAAkk8t3-SqOSnwZTCsK0I',
    appId: '1:145145996116:android:02181821271839eb02dec1',
    messagingSenderId: '145145996116',
    projectId: 'flutter-61ffe',
    databaseURL: 'https://flutter-61ffe-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-61ffe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAOhXcxpxQzglpZEt26KaDdMkfjDKjAoFs',
    appId: '1:145145996116:ios:06b3e3a85bf2e3af02dec1',
    messagingSenderId: '145145996116',
    projectId: 'flutter-61ffe',
    databaseURL: 'https://flutter-61ffe-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'flutter-61ffe.appspot.com',
    iosBundleId: 'com.example.laptopHarbor',
  );

}