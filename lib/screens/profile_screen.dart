import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/providers/user_provider.dart';
import 'package:firebase_chat/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // @override
  // void initState() {
  //   Provider.of<UserProvider>(context).getUserDetail();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                child: Text(userProvider.userName[0]),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                userProvider.userName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),
              ),
              Text(userProvider.userEmail),
              Text(userProvider.userCountry),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditProfileScreen();
                      },
                    ),
                  );
                },
                child: Text("Edit Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
