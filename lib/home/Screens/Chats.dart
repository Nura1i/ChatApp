import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../components/search_page.dart';
import '../../components/user_widget/list_chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chats extends StatefulWidget {
  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  TextEditingController searchUser = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF6F6F6),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: .0,
          foregroundColor: Colors.red,
          leading: TextButton(
            child: const Text(
              'Edit',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff037EE5),
                  fontSize: 17,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {},
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 4,
                child: Text(
                  'Chats',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                      )),
                  child: const Image(
                    image: AssetImage('assets/images/Edit Icon.png'),
                    alignment: Alignment.centerRight,
                  ),
                  // onTap: () async {
                  //   await FirebaseAuth.instance.signOut();
                  //   await GoogleSignIn().signOut();
                  //   Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const login_page(),
                  //   ));
                  // },
                ),
              )
            ],
          ),
          backgroundColor: const Color(0xFFF6F6F6),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: CupertinoSearchTextField(
                placeholder: 'Search for messages',
                prefixInsets: EdgeInsetsDirectional.fromSTEB(
                    MediaQuery.of(context).size.width * 0.23, 0, 0, 0),
                controller: searchUser,
                onChanged: (val) {
                  // setState(() {
                  //   message = val;
                  // });
                },
              ),
            ),
            userView(),
          ],
        ));
  }
}
