import 'package:firebase_chat/providers/user_provider.dart';
import 'package:firebase_chat/screens/dashboard_screen.dart';
import 'package:firebase_chat/screens/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 2),
      () {
        if (user != null) {
          openDashboard();
        } else {
          openLogin();
        }
      },
    );
  }

  void openDashboard() {
    Provider.of<UserProvider>(context, listen: false).getUserDetail();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DashboardScreen(),
      ),
    );
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
