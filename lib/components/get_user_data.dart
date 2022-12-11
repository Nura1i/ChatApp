import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../home/Screens/contacts.dart';

String? userriName;

class getUserName extends StatelessWidget {
  bool isActive = false;
  final String documentId;
  getUserName({required this.documentId});
  bool savedMessage = false;
  VoidCallback? tapp;
  String epm = '';

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
      future: users.doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['id'] == user.uid) {
            userriName = data['username'];
            savedMessage = true;
          }
          if (savedMessage != true) {
            return Column(
              children: [
                ListTile(
                  onTap: onTap,
                  minVerticalPadding: 10,
                  contentPadding: const EdgeInsets.only(left: 15, right: 10),
                  leading: CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.blueGrey,
                      backgroundImage: data['image'] == ''
                          ? const NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/telegramclone-9c564.appspot.com/o/back.jpg?alt=media&token=b2564802-6740-4851-9c19-9082541e99a4')
                          : NetworkImage(data['image']),
                      child: data['image'] == ''
                          ? Text(
                              data['username']
                                  .toString()
                                  .toUpperCase()
                                  .characters
                                  .first,
                            )
                          : SizedBox()
                      // : NetworkImage(data['image']),
                      // child: Text(
                      //   data['username']
                      //       .toString()
                      //       .toUpperCase()
                      //       .characters
                      //       .first,
                      // ),
                      ),
                  title: Text(
                    data['username'],
                    style: const TextStyle(
                        color: Color(0xff000000),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  // subtitle: Text(
                  //   data['userCreatedDate'],
                  //   style: const TextStyle(
                  //       color: Color(0xff7E7E82),
                  //       fontSize: 13,
                  //       fontWeight: FontWeight.w500),
                  // ),
                  trailing: Wrap(
                    spacing: 20,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          CupertinoIcons.text_bubble_fill,
                        ),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.call,
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                Divider(
                  color: const Color(0xff3C3C43).withOpacity(0.3),
                  height: 0,
                  thickness: 0.33,
                  indent: MediaQuery.of(context).size.width * 0.14,
                ),
              ],
            );
          } else {
            return Column(
              children: [
                ListTile(
                  onTap: onTap,
                  contentPadding: const EdgeInsets.only(left: 15, right: 10),
                  leading: const CircleAvatar(
                      radius: 23,
                      // backgroundColor: Colors.blueGrey,
                      child: Image(
                        image: AssetImage(
                            'assets/images/chats/saved_messages.png'),
                        fit: BoxFit.cover,
                      )),
                  title: const Text(
                    'Saved Messages',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Divider(
                  color: const Color(0xff3C3C43).withOpacity(0.3),
                  height: 0,
                  thickness: 0.33,
                  indent: MediaQuery.of(context).size.width * 0.14,
                ),
              ],
            );
          }
        }
        return Container(
          alignment: Alignment.centerLeft,
          child: Lottie.network(
            'https://assets10.lottiefiles.com/packages/lf20_yyytgjwe.json',
            height: MediaQuery.of(context).size.height * 0.05,
          ),
        );
        //  return const Text('loading...');
      },
    );
  }
}
