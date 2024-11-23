import 'package:firebase_chat/providers/user_provider.dart';
import 'package:firebase_chat/screens/chatroom_screen.dart';
import 'package:firebase_chat/screens/profile_screen.dart';
import 'package:firebase_chat/screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var user = FirebaseAuth.instance.currentUser;

  var db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> chatRoomList = [];
  List<String> chatRoomIds = [];

  void getChatRooms() {
    db.collection("chatrooms").get().then(
      (dataSnapshot) {
        for (var singleChatRoomData in dataSnapshot.docs) {
          chatRoomList.add(
            singleChatRoomData.data(),
          );
          chatRoomIds.add(singleChatRoomData.id.toString());
        }
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    getChatRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var userDetail = Provider.of<UserProvider>(context);

    var userProvider = Provider.of<UserProvider>(context);

    var scafoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scafoldKey,
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                leading: CircleAvatar(
                  child: Text(userProvider.userName[0]),
                ),
                title: Text(
                  userProvider.userName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(userProvider.userEmail),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
                leading: const Icon(Icons.person_2_outlined),
                title: const Text("Profile"),
              ),
              ListTile(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashScreen(),
                      ), (route) {
                    return false;
                  });
                },
                leading: const Icon(Icons.logout),
                title: const Text("Logout"),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Global Chat"),
        leading: InkWell(
          onTap: () {
            scafoldKey.currentState!.openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 10,
              child: Text(userProvider.userName[0]),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chatRoomList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatroomScreen(
                      chatRoomName: (chatRoomList[index]["chatroom_name"] ?? "")
                          .toString(),
                      chatRoomId: chatRoomIds[index]),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey[900],
              child: const Text(
                "A",
                style: TextStyle(color: Colors.white),
              ),
            ),
            title: Text(chatRoomList[index]['chatroom_name'] ?? ""),
            subtitle: Text(chatRoomList[index]['desc'] ?? ""),
          );
        },
      ),
    );
  }
}
