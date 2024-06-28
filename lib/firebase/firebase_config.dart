
import 'package:firebase_core/firebase_core.dart';

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
          apiKey: 'AIzaSyCBm8tGDj-2xEkvYvhe06VLeCWljUdvUcY', 
          appId: '1:759092672561:android:6b25df7dc8beb353477d10', 
          messagingSenderId: '759092672561', 
          projectId: 'chateo-aad43',
          storageBucket: 'gs://chateo-aad43.appspot.com',
        );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBm8tGDj-2xEkvYvhe06VLeCWljUdvUcY',
    appId: '1:880126809666:ios:52a355837d47268f907fdb',
    messagingSenderId: '759092672561',
    projectId: 'fir-test-b0de8',
    storageBucket: 'gs://cafealpaso-a253c.appspot.com',
    iosClientId: '880126809666-lb6v57rfk91nd603ht1imiucpkpm89uh.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAuthentication',
  );
}