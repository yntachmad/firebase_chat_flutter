import 'package:firebase_chat/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameText = TextEditingController();

  var db = FirebaseFirestore.instance;

  @override
  void initState() {
    nameText.text = Provider.of<UserProvider>(context, listen: false).userName;
    super.initState();
  }

  var editProfileForm = GlobalKey<FormState>();

  void updateDataName() {
    Map<String, dynamic> updateData = {
      "name": nameText.text,
    };
    db
        .collection("users")
        .doc(Provider.of<UserProvider>(context, listen: false).userID)
        .update(updateData);

    Provider.of<UserProvider>(context, listen: false).getUserDetail();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          actions: [
            InkWell(
              onTap: () {
                if (editProfileForm.currentState!.validate()) {
                  updateDataName();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.check),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: editProfileForm,
            child: Column(
              children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                  },
                  controller: nameText,
                  decoration: const InputDecoration(
                    label: Text('Name'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
