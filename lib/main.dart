import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:firebase_learn/controllers/notification_controller.dart';
import 'package:firebase_learn/screens/sign_in_page.dart';
import 'package:firebase_learn/screens/success_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final auth = FirebaseAuth.instanceFor(app: Firebase.app());

  // GetxController
  Get.lazyPut(() => AuthController());

  // for fb web
  // check if is running on Web
  if (kIsWeb) {
    // To change it after initialization, use `setPersistence()`:
    await auth.setPersistence(Persistence.SESSION);
    // initialize the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "1413902346635433",
      cookie: true,
      xfbml: true,
      version: "v15.0",
    );
  }

  // for firebase notification
  await FirebaseMessaging.instance.requestPermission(
    provisional: true,
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    sound: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase',
      home:
          (FirebaseAuth.instance.currentUser != null)
              ? SuccessScreen(user: FirebaseAuth.instance.currentUser)
              : const SignInScreen(),
    );
  }
}
