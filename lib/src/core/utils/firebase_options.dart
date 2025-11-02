import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform, kIsWeb;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      // case TargetPlatform.

      default:
        throw UnsupportedError("Unsupported platform");
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyD0X1Qqx4z0tVZD6aojlDIASZVvhSvHwOs",
    appId: "mera-bazaar-17b93",
    messagingSenderId: "101644876939",
    storageBucket: "mera-bazaar-17b93.firebasestorage.app",
    projectId: "mera-bazaar-17b93",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyBuwW5GubntMwxyS7F5aBxMbFXRnEMUMAg",
    appId: "mera-bazaar-17b93",
    messagingSenderId: "101644876939",
    storageBucket: "mera-bazaar-17b93.firebasestorage.app",
    iosBundleId: "com.example.meraBazaar",
    projectId: "mera-bazaar-17b93",
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: "AIzaSyBGh7sKgESybnN2B-SNfjZt8H3Gc-Rq2no",
    authDomain: "mera-bazaar-17b93.firebaseapp.com",
    projectId: "mera-bazaar-17b93",
    storageBucket: "mera-bazaar-17b93.firebasestorage.app",
    messagingSenderId: "101644876939",
    appId: "1:101644876939:web:d606d307913e7c5ac4e88e",
    measurementId: "G-56KN88BT65",
  );
}
