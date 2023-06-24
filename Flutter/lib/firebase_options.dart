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
    apiKey: 'AIzaSyAzYJ3WWBmSw3RpZwaoVb9esTKXpWbVlvc',
    appId: '1:709688648039:web:d15284500efcd498aacfc2',
    messagingSenderId: '709688648039',
    projectId: 'fanintegrasiteknoassignment',
    authDomain: 'fanintegrasiteknoassignment.firebaseapp.com',
    storageBucket: 'fanintegrasiteknoassignment.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRCBd4AifJdVMa2pCJAIjxJgPx0NNh0cg',
    appId: '1:709688648039:android:9f4a8d94857fa127aacfc2',
    messagingSenderId: '709688648039',
    projectId: 'fanintegrasiteknoassignment',
    storageBucket: 'fanintegrasiteknoassignment.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC9Q2caLcsG0OfIrHIY7B3f4nnaDfRshvg',
    appId: '1:709688648039:ios:1eb992b34f6d332eaacfc2',
    messagingSenderId: '709688648039',
    projectId: 'fanintegrasiteknoassignment',
    storageBucket: 'fanintegrasiteknoassignment.appspot.com',
    iosClientId: '709688648039-ljgajdc49o6nnf4lltp6malumukvug82.apps.googleusercontent.com',
    iosBundleId: 'com.example.ptFanIntegrasiTeknologiAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC9Q2caLcsG0OfIrHIY7B3f4nnaDfRshvg',
    appId: '1:709688648039:ios:9c5010eed652d00faacfc2',
    messagingSenderId: '709688648039',
    projectId: 'fanintegrasiteknoassignment',
    storageBucket: 'fanintegrasiteknoassignment.appspot.com',
    iosClientId: '709688648039-55nv3e7aro7oaldhfhdd90edet8i30gh.apps.googleusercontent.com',
    iosBundleId: 'com.example.ptFanIntegrasiTeknologiAssignment.RunnerTests',
  );
}
