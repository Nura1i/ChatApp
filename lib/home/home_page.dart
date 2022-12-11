import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/get_user_data.dart';
import 'Screens/calls.dart';
import 'Screens/chats.dart';
import 'Screens/contacts.dart';
import 'Screens/settings.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({
    super.key,
  });

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  dynamic screens = [contacts(), Calls(), Chats(), const settings()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFF6F6F6),
      child: Scaffold(
        body: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            iconSize: 30,
            backgroundColor: const Color(0xFFF6F6F6),
            items: [
              const BottomNavigationBarItem(
                label: "Contacts",
                icon: Icon(CupertinoIcons.person_crop_circle),
              ),
              const BottomNavigationBarItem(
                label: "Calls",
                icon: Icon(CupertinoIcons.phone_fill),
              ),
              const BottomNavigationBarItem(
                label: "Chats",
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
              ),
              BottomNavigationBarItem(
                activeIcon: DecoratedBox(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Color(0xff037EE5))),
                    child: Padding(
                      padding: const EdgeInsets.all(1.7),
                      child: CircleAvatar(
                          radius: MediaQuery.of(context).size.width * 0.035,
                          backgroundColor: Colors.blueGrey,
                          child: Text(userriName
                              .toString()
                              .toUpperCase()
                              .characters
                              .first)),
                    )),
                label: "Settings",
                icon: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.035,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                        userriName.toString().toUpperCase().characters.first)),
              )
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return screens[index];
          },
        ),
      ),
    );
  }
}
