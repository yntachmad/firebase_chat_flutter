import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var db = FirebaseFirestore.instance;
  var authActive = FirebaseAuth.instance.currentUser;

  Map<String, dynamic>? userData = {};

  void getData() {
    try {
      db.collection("users").doc(authActive!.uid).get().then((dataSnapshot) {
        userData = dataSnapshot.data();
        setState(() {});
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(userData?["name"] ?? ""),
            Text(userData?["email"] ?? ""),
            Text(userData?["country"] ?? ""),
          ],
        ),
      ),
    );
  }
}
