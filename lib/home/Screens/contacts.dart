import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

import '../../components/get_user_data.dart';

var noww = '${DateTime.now().hour}' + ':' + '' + '${DateTime.now().minute}';
var user = FirebaseAuth.instance.currentUser!;

List<String> usersData = [];
String username = '';
Future getUsersData() async {
  await FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((snapshot) => snapshot.docs.forEach((document) {
            print(document.toString());

            usersData.add(document.reference.id);
          }));
}

bool isActiveSearch = false;
var newUser = user;
var currentUser = FirebaseAuth.instance.currentUser?.uid;
VoidCallback? onTap;
bool savedMessage = false;
bool isActivedSeach = true;

class contacts extends StatefulWidget {
  @override
  State<contacts> createState() => _contactsState();
}

class _contactsState extends State<contacts> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Recently Registered',
            style: GoogleFonts.robotoMono(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 19),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffF6F6F6),
          elevation: .0,
        ),
        body: Column(
          children: [
            // Text(user.email.toString()),
            InkWell(
              onTap: () {},
              highlightColor: Colors.white.withOpacity(0.4),
              splashColor: Colors.blueAccent.withOpacity(0.5),
              child: ListTile(
                contentPadding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.062),
                horizontalTitleGap: 0,
                minVerticalPadding: 10,
                minLeadingWidth: MediaQuery.of(context).size.width * 0.11,
                leading: SvgPicture.asset('assets/images/svg/location.svg',
                    height: 23),
                title: const Text(
                  'Add People Nearby',
                  style: TextStyle(color: Color(0xff037EE5), fontSize: 18),
                ),
                trailing: isActivedSeach
                    ? IconButton(
                        splashRadius: 1,
                        padding: const EdgeInsets.only(right: 32),
                        onPressed: () {
                          setState(() {
                            isActiveSearch = true;
                            isActivedSeach = false;
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.search_circle_fill,
                          size: MediaQuery.of(context).size.height * 0.035,
                        ))
                    : IconButton(
                        splashRadius: 1,
                        padding: const EdgeInsets.only(right: 32),
                        onPressed: () {
                          setState(() {
                            isActiveSearch = false;
                            isActivedSeach = true;
                          });
                        },
                        icon: Icon(
                          CupertinoIcons.xmark_circle_fill,
                          size: MediaQuery.of(context).size.height * 0.035,
                        )),
                visualDensity: VisualDensity.comfortable,
              ),
            ),

            isActiveSearch
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: CupertinoSearchTextField(
                      autofocus: true,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(22, 8, 5, 8),
                      placeholder: 'Search for users',
                      prefixInsets: EdgeInsetsDirectional.fromSTEB(
                          MediaQuery.of(context).size.width * 0.03, 0, 0, 0),
                      //controller: searchUser,
                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                    ),
                  )
                : SizedBox(),

            Divider(
              color: const Color(0xff3C3C43).withOpacity(0.3),
              height: 5,
              thickness: 0.33,
              indent: MediaQuery.of(context).size.width * 0.03,
              endIndent: MediaQuery.of(context).size.width * 0.03,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshots.data!.docs.length,
                          itemBuilder: (context, index) {
                            var data = snapshots.data!.docs[index].data()
                                as Map<String, dynamic>;

                            if (data['id'] == user.uid) {
                              userriName = data['username'];
                              savedMessage = true;
                            }

                            if (username.isEmpty) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      data['username'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      data['email'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    leading: CircleAvatar(
                                      radius: 23,
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
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 32, 31, 44),
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const SizedBox(),
                                    ),
                                    trailing: Wrap(
                                      children: <Widget>[
                                        IconButton(
                                          highlightColor: Colors.grey,
                                          icon: const Icon(
                                            CupertinoIcons.text_bubble_fill,
                                            color: Color.fromARGB(
                                                255, 207, 207, 207),
                                          ),
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                          highlightColor: Colors.blueGrey,
                                          icon: const Icon(
                                            Icons.call,
                                            color: Color.fromARGB(
                                                255, 13, 92, 129),
                                          ),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: const Color(0xff3C3C43)
                                        .withOpacity(0.3),
                                    height: 0,
                                    thickness: 0.33,
                                    indent: MediaQuery.of(context).size.width *
                                        0.14,
                                  ),
                                ],
                              );
                            }
                            if (data['username']
                                .toString()
                                .toLowerCase()
                                .startsWith(username.toLowerCase())) {
                              return ListTile(
                                title: Text(
                                  data['username'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: data['image'] == ''
                                      ? const NetworkImage(
                                          'https://firebasestorage.googleapis.com/v0/b/telegramclone-9c564.appspot.com/o/avatar.png?alt=media&token=21a31794-3a45-46cf-a4aa-2bf5f1502742')
                                      : NetworkImage(data['image']),
                                ),
                              );
                            }
                            return Container();
                          });
                },
              ),
            ),
          ],
        ));
  }
}
