import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:firebase_learn/screens/sign_in_page.dart';
import 'package:firebase_learn/screens/success_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart' as Permission;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

// notification
notificationHandler() async {
  // var permission = Permission.AndroidNotification();

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

  // start background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
      Get.snackbar(message.data.toString(), message.notification.toString());
    }
  });

  // print token
  final token = await FirebaseMessaging.instance.getToken();
  debugPrint("token is: $token");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize firebase app
  await firebaseInit();

  // notification
  await notificationHandler();

  // GetxController
  Get.lazyPut(() => AuthController());

  // main method
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
