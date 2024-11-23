import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_chat/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatroomScreen extends StatefulWidget {
  String chatRoomName;
  String chatRoomId;
  ChatroomScreen(
      {super.key, required this.chatRoomName, required this.chatRoomId});

  @override
  State<ChatroomScreen> createState() => _ChatroomScreenState();
}

class _ChatroomScreenState extends State<ChatroomScreen> {
  TextEditingController messageText = TextEditingController();

  var db = FirebaseFirestore.instance;

  Future<void> sendMessage() async {
    if (messageText.text.isEmpty) {
      return; // Do not send empty messages
    }
    Map<String, dynamic> messageToSend = {
      'text': messageText.text,
      "sender_name": Provider.of<UserProvider>(context, listen: false).userName,
      "chatroom_id": widget.chatRoomId,
      "timestamp": FieldValue.serverTimestamp()
    };

    try {
      await db.collection("messages").add(messageToSend);

      messageText.clear();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.chatRoomName),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: db
                    .collection("messages")
                    .where("chatroom_id", isEqualTo: widget.chatRoomId)
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text("Error: ${snapshot.error}");
                  }
                  var allMessages = snapshot.data?.docs ?? [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: allMessages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allMessages[index]["sender_name"],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(allMessages[index]["text"]),
                            SizedBox(
                              height: 8,
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              color: Colors.grey[200],
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageText,
                      decoration: InputDecoration(
                        hintText: "Write Message here....",
                        border: InputBorder.none,
                      ),
                    )),
                    InkWell(
                      onTap: sendMessage,
                      child: Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
