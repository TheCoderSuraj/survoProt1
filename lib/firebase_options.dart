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
    apiKey: 'AIzaSyB4se9H3DX-hFAOhHPPaaMC_V0yJNJS4Dc',
    appId: '1:1073838987408:web:ca747c3b8fe3d010c76015',
    messagingSenderId: '1073838987408',
    projectId: 'survoprot',
    authDomain: 'survoprot.firebaseapp.com',
    storageBucket: 'survoprot.appspot.com',
    measurementId: 'G-RYPS6C61L1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBALNbn3j-Dsn9KuiqSpokGkiUgk_FZlAU',
    appId: '1:1073838987408:android:4d15e10163ffd42dc76015',
    messagingSenderId: '1073838987408',
    projectId: 'survoprot',
    storageBucket: 'survoprot.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAGl3PFx66x5bSfhB276_E98T1xF7WKXmg',
    appId: '1:1073838987408:ios:ea85f088c059e7b9c76015',
    messagingSenderId: '1073838987408',
    projectId: 'survoprot',
    storageBucket: 'survoprot.appspot.com',
    iosClientId: '1073838987408-fvlhbn19tie7m0s7jkbec6tpp1mm992f.apps.googleusercontent.com',
    iosBundleId: 'com.example.survoProtv1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAGl3PFx66x5bSfhB276_E98T1xF7WKXmg',
    appId: '1:1073838987408:ios:ea85f088c059e7b9c76015',
    messagingSenderId: '1073838987408',
    projectId: 'survoprot',
    storageBucket: 'survoprot.appspot.com',
    iosClientId: '1073838987408-fvlhbn19tie7m0s7jkbec6tpp1mm992f.apps.googleusercontent.com',
    iosBundleId: 'com.example.survoProtv1',
  );
}