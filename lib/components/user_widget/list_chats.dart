import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:telegram_clone/new_messenger/views/home.dart';
import '../../home/Screens/chat/chat_view.dart';
import '../credential.dart';

class userView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 30,
                child: Text(
                  'G',
                  style: TextStyle(color: Colors.white, fontSize: 23),
                ),
              ),
              title: const Text(
                'Group',
                textAlign: TextAlign.start,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                mess == null ? 'sms' : mess!,
                style: const TextStyle(color: Colors.black),
              )),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(
                    userCredential: mine_creden!,
                  ),
                ));
          },
        ),
      ],
    );
  }
}
