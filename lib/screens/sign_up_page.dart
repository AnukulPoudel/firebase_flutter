import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:firebase_learn/screens/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final device = MediaQuery.of(context).size;
    final controller = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Create Account"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            Text("Or use your E-mail for registration"),
            // SizedBox(
            //   width: device.width * 0.6,
            //   child: TextField(
            //     controller: nameController,
            //     decoration: InputDecoration(label: Text("Name")),
            //   ),
            // ),
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
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await controller.signUpWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
              ),
              child: Text("Sign Up", style: TextStyle(color: Colors.white)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account? "),
                TextButton(
                  onPressed: () {
                    Get.to(() => SignInScreen());
                  },
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
