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
      // case TargetPlatform.android:
      //   return android;
      // case TargetPlatform.iOS:
      //   return ios;
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
    apiKey: 'AIzaSyAOfRvjly69ojg07GEPibJ317ZKWOf_xYQ',
    appId: '1:1035864473106:android:c93fa8105cf1fd445d62cb',
    messagingSenderId: '1035864473106',
    projectId: 'systempointofsale-1b0e2',
    databaseURL: 'https://systempointofsale-1b0e2-default-rtdb.firebaseio.com',
    storageBucket: 'systempointofsale-1b0e2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBG--HF8hH88079hOy6QcAYsrRzNAIIDJM',
    appId: '1:1035864473106:ios:442899101815fb6c5d62cb',
    messagingSenderId: '1035864473106',
    projectId: 'systempointofsale-1b0e2',
    databaseURL: 'https://systempointofsale-1b0e2-default-rtdb.firebaseio.com',
    storageBucket: 'systempointofsale-1b0e2.appspot.com',
    androidClientId: '1035864473106-2v65gevem0sui3h94am1c1hp4s9tlils.apps.googleusercontent.com',
    iosClientId: '1035864473106-0o9oje0viie39bnni2cahsu06bfmdk5p.apps.googleusercontent.com',
    iosBundleId: 'com.nexevol.agent',
  );
}