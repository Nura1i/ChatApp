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
    apiKey: 'AIzaSyDRIZE_4Rc-7gUvBk9YCe_cCQoqYQegca8',
    appId: '1:321181927789:web:0d08251a0b25872d723264',
    messagingSenderId: '321181927789',
    projectId: 'telegramclone-9c564',
    authDomain: 'telegramclone-9c564.firebaseapp.com',
    storageBucket: 'telegramclone-9c564.appspot.com',
    measurementId: 'G-ZHH5QYRF12',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBF6u0qFo9dWRL8ntldkOMFyu9aXKGpR0c',
    appId: '1:321181927789:android:f8fabd21f34d80ce723264',
    messagingSenderId: '321181927789',
    projectId: 'telegramclone-9c564',
    storageBucket: 'telegramclone-9c564.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaDaRSS-ffa6Vk0f8xtt73bD4ZsTGZSEM',
    appId: '1:321181927789:ios:180f806423a6c20a723264',
    messagingSenderId: '321181927789',
    projectId: 'telegramclone-9c564',
    storageBucket: 'telegramclone-9c564.appspot.com',
    iosClientId:
        '321181927789-o0rddkro0s0oknh56k5c1pdb4adcqcb3.apps.googleusercontent.com',
    iosBundleId: 'com.example.telegramClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaDaRSS-ffa6Vk0f8xtt73bD4ZsTGZSEM',
    appId: '1:321181927789:ios:180f806423a6c20a723264',
    messagingSenderId: '321181927789',
    projectId: 'telegramclone-9c564',
    storageBucket: 'telegramclone-9c564.appspot.com',
    iosClientId:
        '321181927789-o0rddkro0s0oknh56k5c1pdb4adcqcb3.apps.googleusercontent.com',
    iosBundleId: 'com.example.telegramClone',
  );
}