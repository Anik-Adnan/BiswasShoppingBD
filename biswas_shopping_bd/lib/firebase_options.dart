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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBxLhzYriVT5bmQulhJBVbTMrBQttSgKTw',
    appId: '1:679771843332:web:c194a8b318e2656dbc7e51',
    messagingSenderId: '679771843332',
    projectId: 'biswasshoppingbd-5c83b',
    authDomain: 'biswasshoppingbd-5c83b.firebaseapp.com',
    storageBucket: 'biswasshoppingbd-5c83b.appspot.com',
    measurementId: 'G-JKDNH4LVL0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAiWpYU2qvdxf1JQ8ZSjXs8n3PSTlilOH8',
    appId: '1:679771843332:android:d45e8b5eb9670006bc7e51',
    messagingSenderId: '679771843332',
    projectId: 'biswasshoppingbd-5c83b',
    storageBucket: 'biswasshoppingbd-5c83b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqwbG2ibnkqC5mBU2yQS6T4wiN9wGE7cg',
    appId: '1:679771843332:ios:997252d9aed46edfbc7e51',
    messagingSenderId: '679771843332',
    projectId: 'biswasshoppingbd-5c83b',
    storageBucket: 'biswasshoppingbd-5c83b.appspot.com',
    iosBundleId: 'com.example.biswasShoppingBd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqwbG2ibnkqC5mBU2yQS6T4wiN9wGE7cg',
    appId: '1:679771843332:ios:997252d9aed46edfbc7e51',
    messagingSenderId: '679771843332',
    projectId: 'biswasshoppingbd-5c83b',
    storageBucket: 'biswasshoppingbd-5c83b.appspot.com',
    iosBundleId: 'com.example.biswasShoppingBd',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBxLhzYriVT5bmQulhJBVbTMrBQttSgKTw',
    appId: '1:679771843332:web:99205853d78bb577bc7e51',
    messagingSenderId: '679771843332',
    projectId: 'biswasshoppingbd-5c83b',
    authDomain: 'biswasshoppingbd-5c83b.firebaseapp.com',
    storageBucket: 'biswasshoppingbd-5c83b.appspot.com',
    measurementId: 'G-ZL76FHW72E',
  );
}
