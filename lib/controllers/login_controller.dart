import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Future<void> loginAccount(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ), (route) {
        return false;
      });

      SnackBar messageSnackBar = const SnackBar(
        // backgroundColor: Colors.red,
        content: Text("Sign in Successfully"),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);

      // print("Account Created Successfully");
    } catch (e) {
      SnackBar messageSnackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(messageSnackBar);
      // print(e);
    }
  }
}
