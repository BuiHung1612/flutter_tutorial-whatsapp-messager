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
    apiKey: 'AIzaSyClf8x0uA6G-NGE5mP9ueg4uefYVSfimI4',
    appId: '1:958399207916:android:8380bf9048a189584ec8c9',
    messagingSenderId: '958399207916',
    projectId: 'flutter-test-7ea1d',
    storageBucket: 'flutter-test-7ea1d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYBCx6loI3-02yQ-Iejyx_m-5B1GP7_F4',
    appId: '1:958399207916:ios:cbeebe80e8ee6a9d4ec8c9',
    messagingSenderId: '958399207916',
    projectId: 'flutter-test-7ea1d',
    storageBucket: 'flutter-test-7ea1d.appspot.com',
    androidClientId: '958399207916-g1rvs5u20var0ol5sb21gpptekrb3vid.apps.googleusercontent.com',
    iosClientId: '958399207916-a5sejl3kc2n95bej3mr8kgpn3u1enujq.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappMessenger',
  );
}
