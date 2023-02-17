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
    apiKey: 'AIzaSyBOg7lnJpqSIUWZevbhtr0h7PoXehJVlIw',
    appId: '1:258722761535:web:dd7e786cc2882528baa18a',
    messagingSenderId: '258722761535',
    projectId: 'newstime-cc7c3',
    authDomain: 'newstime-cc7c3.firebaseapp.com',
    storageBucket: 'newstime-cc7c3.appspot.com',
    measurementId: 'G-JPZ0QZWTE4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu1LelRHFVUIHZxRnp6-EvEEXgxsKmwCE',
    appId: '1:258722761535:android:74752c6a581c589ebaa18a',
    messagingSenderId: '258722761535',
    projectId: 'newstime-cc7c3',
    storageBucket: 'newstime-cc7c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmFoav_qke8MlE6TW1oIyPYHVRkbGURRo',
    appId: '1:258722761535:ios:5fd6ed41845252f2baa18a',
    messagingSenderId: '258722761535',
    projectId: 'newstime-cc7c3',
    storageBucket: 'newstime-cc7c3.appspot.com',
    iosClientId: '258722761535-ej7svoa50mgmk31djls70c9fntv2fteq.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAmFoav_qke8MlE6TW1oIyPYHVRkbGURRo',
    appId: '1:258722761535:ios:6498bad6619124e7baa18a',
    messagingSenderId: '258722761535',
    projectId: 'newstime-cc7c3',
    storageBucket: 'newstime-cc7c3.appspot.com',
    iosClientId: '258722761535-7qmi257ls4djvmf94434qsiv5r72smr8.apps.googleusercontent.com',
    iosBundleId: 'com.example.newsTime.RunnerTests',
  );
}
