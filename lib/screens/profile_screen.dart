import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(userProvider.userID),
            Text(userProvider.userName),
            Text(userProvider.userEmail),
            Text(userProvider.userCountry),
          ],
        ),
      ),
    );
  }
}
