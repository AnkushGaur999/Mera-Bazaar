import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {

  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError("Unsupported platform");
    }
  }

  static const FirebaseOptions android = FirebaseOptions
    (apiKey: "AIzaSyD0X1Qqx4z0tVZD6aojlDIASZVvhSvHwOs",
      appId: "mera-bazaar-17b93",
      messagingSenderId: "101644876939",
      storageBucket: "mera-bazaar-17b93.firebasestorage.app",
      projectId: "mera-bazaar-17b93");

  static const FirebaseOptions ios = FirebaseOptions
    (
    apiKey: "AIzaSyBuwW5GubntMwxyS7F5aBxMbFXRnEMUMAg",
    appId: "mera-bazaar-17b93",
    messagingSenderId: "101644876939",
    storageBucket: "mera-bazaar-17b93.firebasestorage.app",
    iosBundleId: "com.example.meraBazaar",
    projectId: "mera-bazaar-17b93",);
}
