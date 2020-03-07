import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_messaging_practice/models/message.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  List<Message> _messagesList = [];
  @override
  void initState() {
    super.initState();

    _getDeviceToken();
    _configureFirebaseMessagingListeners();
  }

  _getDeviceToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      print("My Device Token is : $deviceToken");
    });
  }

  _configureFirebaseMessagingListeners() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print(message);
      _setMessage(message);
    }, onLaunch: (Map<String, dynamic> message) async {
      print(message);
      _setMessage(message);
    }, onResume: (Map<String, dynamic> message) async {
      print(message);
      _setMessage(message);
    });
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final title = notification['title'];
    final body = notification['body'];
    final myMessage = message['data']['message'];
    Message _message = Message(title, body, myMessage);

    setState(() {
      _messagesList.add(_message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Firebase Messaging",
        ),
      ),
      body: _messagesList.length == 0
          ? Center(
              child: Container(
              child: Text("No data"),
            ))
          : ListView.builder(
              itemCount: _messagesList.length,
              itemBuilder: (context, int index) {
                //print(_messagesList[index]);
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(_messagesList[index].message),
                  ),
                );
              }),
    );
  }
}
