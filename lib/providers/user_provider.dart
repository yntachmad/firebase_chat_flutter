import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String userName = "Dummy Name";
  String userEmail = "Dummy Email";
  String userCountry = "Dummy Country";
  String userID = "Dummy ID";

  var db = FirebaseFirestore.instance;
  var authActive = FirebaseAuth.instance.currentUser;

  void getUserDetail() {
    try {
      db.collection("users").doc(authActive!.uid).get().then((dataSnapshot) {
        userName = dataSnapshot.data()?['name'] ?? "";
        userEmail = dataSnapshot.data()?['email'] ?? "";
        userCountry = dataSnapshot.data()?['country'] ?? "";
        userID = dataSnapshot.data()?['id'] ?? "";
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // UserProvider(this.userName, this.userEmail, this.userCountry, this.userID);
}
