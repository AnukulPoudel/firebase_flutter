import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, this.user});

  final User? user;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    print(user.toString());
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await controller.signOut();
            },
            child: Text("Sign Out"),
          ),
          SizedBox(height: 10),
          Text("Welcome , ${user!.email}"),
        ],
      ),
    );
  }
}
