import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:firebase_learn/screens/sign_in_page.dart';
import 'package:firebase_learn/screens/success_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final auth = FirebaseAuth.instanceFor(app: Firebase.app());
  // To change it after initialization, use `setPersistence()`:
  await auth.setPersistence(Persistence.SESSION);

  // GetxController
  Get.lazyPut(() => AuthController());

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
