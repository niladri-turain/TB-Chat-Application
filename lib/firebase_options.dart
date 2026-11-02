import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web is not configured for this project.');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAGcz1ytYZSQSGu1rBpdA1LxBg67Q2SrNI',
    appId: '1:681275363583:android:e3f03bf41a69d9391e7cca',
    messagingSenderId: '681275363583',
    projectId: 'tb-chat-application',
    storageBucket: 'tb-chat-application.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_P15a3si5pmu3dp_S3W6ooH9tiLhzW24',
    appId: '1:681275363583:ios:8ffa4f0c75aae7741e7cca',
    messagingSenderId: '681275363583',
    projectId: 'tb-chat-application',
    storageBucket: 'tb-chat-application.firebasestorage.app',
    iosBundleId: 'com.example.tbChatApplication',
  );
}
