import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learn/screens/sign_in_page.dart';
import 'package:firebase_learn/screens/success_page.dart';
import 'package:firebase_learn/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

User? user;
// final authStateChanges = _firebaseAuth.authStateChanges();

class AuthController extends GetxController {
  // checkCurrentAuthState (){
  //   _firebaseAuth.authStateChanges().listen(User? user){
  //     if (user==null) {
  //       print('User is signed out');
  //     }
  //     else{
  //       print('user is signed in');
  //     }
  //   }
  // }

  final AuthServices _services = AuthServices();

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _services.signUpWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential!.user;
      if (user != null) {
        Get.off(() => SuccessScreen(user: user!));
      } else {
        debugPrint("User is null in signInEmailAndPassword in controller");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "weak-password") {
        Get.snackbar('Error', "Weak Password");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', "Email already in use");
      } else {
        debugPrint(e.code);
        Get.snackbar('Error', "Something went wrong");
      }
    }
    // catch (e) {
    //   return SignUpState.other;
    // }
  }

  Future<void> signInEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _services.signInEmailAndPassword(
        email: email,
        password: password,
      );
      user = credential!.user;
      if (user != null) {
        Get.off(() => SuccessScreen(user: user!));
      } else {
        debugPrint("User is null in signInEmailAndPassword in controller");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', "user not found for that email");
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', "Wrong password provided for that user.");
      }
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final credential = await _services.googleSignInOption();
      user = credential!.user;
      if (user != null) {
        Get.off(() => SuccessScreen(user: user!));
      } else {
        debugPrint("User is null in signinwith google in controller");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', "Something went wrong ${e.code}!!");
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final credential = await _services.facebookSignInOption();
      user = credential!.user;
      if (user != null) {
        Get.off(() => SuccessScreen(user: user!));
      } else {
        debugPrint("user is null in sign in with faceboo in controller");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error", "something went wrong! $e");
    }
  }

  Future<void> signOut() async {
    await _services.signOut();
    Get.offAll(() => SignInScreen());
  }
}
