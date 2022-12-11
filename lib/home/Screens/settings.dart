import 'dart:core';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:telegram_clone/components/get_user_data.dart';
import 'package:telegram_clone/components/user_widget/model/user_model.dart';
import 'package:telegram_clone/home/Screens/contacts.dart';
import 'package:telegram_clone/home/Screens/setting_fields/edit_profile.dart';
import 'package:uuid/uuid.dart';
import '../../loginPage/login_page.dart';
import 'chat/chat_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

TextEditingController searchController = TextEditingController();
User me = FirebaseAuth.instance.currentUser!;
final aa = Uuid().v1();
String idd = FirebaseAuth.instance.currentUser!.uid;

class _settingsState extends State<settings> {
  void logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const login_page()),
            (route) => false);
      });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF6F6F6),
        elevation: .0,
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text(
                'Edit',
                style: TextStyle(
                    color: Color(0xff037EE5),
                    fontSize: 17,
                    fontWeight: FontWeight.w400),
              ))
        ],
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
      backgroundColor: Color(0xffF2F2F2),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.07,
              color: Color(0xffF6F6F6),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CupertinoSearchTextField(
                  prefixInsets: EdgeInsetsDirectional.fromSTEB(
                      MediaQuery.of(context).size.width * 0.37, 0, 0, 0),
                  controller: searchController,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const editProfile(),
                    ));
              },
              child: Card(
                margin: const EdgeInsets.only(bottom: 2),
                elevation: 0.6,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                    right: 16,
                    left: 6,
                  ),
                  leading: CircleAvatar(
                    radius: 33,
                    backgroundColor: Colors.blueGrey,
                    child: Text(userriName.toString().characters.first),
                  ),
                  title: Text(
                    userriName!,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  subtitle: Text(
                    me.email.toString(),
                  ),
                  trailing: const Icon(CupertinoIcons.right_chevron, size: 15),
                ),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    minLeadingWidth: MediaQuery.of(context).size.width * 0.12,
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      child: Text(
                        userriName.toString().characters.first,
                      ),
                    ),
                    title: Text(userriName!,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400)),
                  ),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.06),
                    leading: const Icon(
                      CupertinoIcons.plus,
                      color: Color(0xff007AFF),
                    ),
                    title: const Text(
                      'Add Account',
                      style: TextStyle(color: Color(0xff037EE5), fontSize: 17),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: Column(
                children: [
                  settingField('assets/images/settings/savedMessage.png',
                      'Saved Messages'),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  settingField(
                      'assets/images/settings/recentCall.png', 'Recent Calls'),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  settingField(
                      'assets/images/settings/sticker.png', 'Stickers'),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              child: Column(
                children: [
                  settingField('assets/images/settings/notification.png',
                      'Notifications and Sounds'),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  settingField('assets/images/settings/security.png',
                      'Privacy and Security'),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  settingField('assets/images/settings/data_storage.png',
                      'Data and Storage'),
                  Divider(
                    color: const Color(0xFFF6F6F6),
                    thickness: 1.7,
                    indent: MediaQuery.of(context).size.width * 0.2,
                    height: 0,
                  ),
                  settingField(
                      'assets/images/settings/appearance.png', 'Appearance'),
                ],
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Card(
              child: GestureDetector(
                onTap: () async {
                  logout(context);
                  await GoogleSignIn().signOut();
                  await FirebaseAuth.instance.signOut();
                  setState(() {
                    currentUser = '';

                    user = ''.toString() as User;
                  });
                },
                child: ListTile(
                  contentPadding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.06),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 28,
                  ),
                  title: const Text('Log Out',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.red)),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: const Color(0xff3C3C43).withOpacity(0.3),
                      size: 17,
                    ),
                  ),
                ),
              ),
            ),

            // Center(
            //     child: ElevatedButton(
            //         onPressed: () async {
            //           logout(context);
            //           await GoogleSignIn().signOut();
            //           setState(() {
            //             userEmail = "";
            //           });
            //         },
            //         child: const Text('Log Out'))),
          ],
        ),
      ),
    );
  }

  settingField(String icon, String text) {
    return InkWell(
      child: ListTile(
        onTap: () {},
        contentPadding:
            EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.06),
        leading: Image(
          image: AssetImage(
            icon,
          ),
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width * 0.075,
          height: MediaQuery.of(context).size.height * 0.034,
        ),
        title: Text(text,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            CupertinoIcons.right_chevron,
            color: const Color(0xff3C3C43).withOpacity(0.3),
            size: 17,
          ),
        ),
      ),
    );
  }
}
