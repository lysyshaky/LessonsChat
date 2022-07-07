import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:lessons_chat/screens/login_screen.dart';
import 'package:lessons_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:lessons_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = '/chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore = FirebaseFirestore.instance.collection('messages');
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  String messageText;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void messagesStream() async {
    await for (var snapshot in _firestore.snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pushNamed(context, LoginScreen.id);
                //Implement logout functionality
              }),
        ],
        title: Text('Lessons Chat'),
        backgroundColor: Color.fromARGB(255, 1, 61, 152),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Stream Data from Firebase
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.snapshots(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data.docs;
                  List<MessageBubble> messageBubbles = [];
                  for (var message in messages) {
                    Map<String, dynamic> messageData = message.data();
                    final messageText = messageData['text'];
                    final messageSender = messageData['sender'];
                    final messageBubble = MessageBubble(
                      sender: messageSender,
                      text: messageText,
                    );
                    messageBubbles.add(messageBubble);
                  }
                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
                      children: messageBubbles,
                    ),
                  );
                }
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        messageText = value;
                        //Do something with the user input.
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      //messeage + loggedInUser.email
                      _firestore.add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                      });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.sender, this.text});

  final String sender;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.lightBlueAccent,
      child: Text(
        '$text from $sender',
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }
}
