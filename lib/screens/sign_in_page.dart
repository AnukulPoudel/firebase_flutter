import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'sign_up_page.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Sign In"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TODO:
                IconButton(
                  onPressed: () async {
                    await controller.signInWithFacebook();
                  },
                  icon: Icon(Icons.facebook),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await controller.signInWithGoogle();
                  },
                  icon: Icon(Icons.g_mobiledata_rounded),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.grey),
                  ),
                ),
              ],
            ),
            Text("Or sign-in using E-mail Address"),
            SizedBox(
              width: device.width * 0.6,
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(label: Text("E-mail")),
              ),
            ),
            SizedBox(
              width: device.width * 0.6,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(label: Text("Password")),
                obscureText: true,
              ),
            ),
            TextButton(onPressed: () {}, child: Text("Forgot your password?")),
            ElevatedButton(
              onPressed: () async {
                await controller.signInEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
              ),
              child: Text("Sign In", style: TextStyle(color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Create an Account? "),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignUpScreen());
                  },
                  child: Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
