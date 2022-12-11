import 'dart:developer';

import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:get/get.dart';
import 'package:telegram_clone/home/Screens/chat/chat_controller.dart';

import '../../../components/user_widget/model/message_model.dart';
import '../../../services/fire_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required UserCredential userCredential});

  @override
  State<HomePage> createState() => _HomePageState();
}

String? supp;
String? mess;

class _HomePageState extends State<HomePage> {
  ///set/ double? _currentPosition = 0;
  final controller = Get.put<ScrollControllerGetx>(ScrollControllerGetx());

  String timePub = '';
  @override
  Widget build(BuildContext context) {
    log('BUILD');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF6F6F6),
          elevation: .0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Image(
                  image: AssetImage('assets/images/Back.png'),
                  width: 70,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.07),
                child: const Text(
                  'Group',
                  style: TextStyle(color: Colors.black, fontSize: 23),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.scrollController!.animateTo(
                      controller.scrollController!.position.minScrollExtent,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  child: Container(),
                ),
              )
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            const Image(
              image: AssetImage('assets/images/background_chats.png'),
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.07),
              child: FirestoreListView(
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  query: FireDatabaseService.databaseFirestore
                      .collection('messages')
                      .orderBy('publishedDate', descending: false),
                  loadingBuilder: (context) =>
                      const CupertinoActivityIndicator(),
                  itemBuilder: (context, doc) {
                    if (!doc.exists) {
                      return const Text('document not found');
                    }
                    MessageModel? message = MessageModel.fromJson(doc.data());

                    timePub =
                        '${message.publishedDate!.hour}:${message.publishedDate!.minute}';
                    if (message.publishedDate!.hour < 10) {
                      timePub =
                          '0${message.publishedDate!.hour}:${message.publishedDate!.minute}';
                    }
                    if (message.publishedDate!.minute < 10) {
                      timePub =
                          '${message.publishedDate!.hour}:0${message.publishedDate!.minute}';
                    }
                    if (message.publishedDate!.hour < 10 &&
                        message.publishedDate!.minute < 10) {
                      timePub =
                          '0${message.publishedDate!.hour}:0${message.publishedDate!.minute}';
                    }
                    return Align(
                      alignment: message.userId ==
                              FirebaseAuth.instance.currentUser!.uid
                          ? FractionalOffset.centerRight
                          : FractionalOffset.centerLeft,
                      child: Padding(
                        padding: message.userId ==
                                FirebaseAuth.instance.currentUser!.uid
                            ? const EdgeInsets.only(left: 70)
                            : const EdgeInsets.only(right: 70),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 5, bottom: 5),
                          child: Bubble(
                            nip: message.userId ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? BubbleNip.rightBottom
                                : BubbleNip.leftBottom,
                            color: message.userId ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? const Color(0xFFE1FEC6)
                                : const Color(0xFFFFFFFF),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    message.userId ==
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                        ? const SizedBox()
                                        : Text(
                                            message.username!,
                                            style: TextStyle(
                                                color: message.userId ==
                                                        FirebaseAuth.instance
                                                            .currentUser!.uid
                                                    ? Colors.transparent
                                                    : const Color(0XFF037EE5),
                                                fontWeight: FontWeight.bold),
                                          ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            message.text ?? 'text',
                                            style:
                                                const TextStyle(fontSize: 15),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child: Text(
                                                timePub,
                                                style: TextStyle(
                                                    color: message.userId ==
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                        ? const Color(
                                                            0xff2DA430)
                                                        : const Color(
                                                            0XFF8E8E93),
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Positioned(
                bottom: 0,
                left: .0,
                right: .0,
                child: Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.070,
                  decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: const Image(
                                image: AssetImage('assets/images/send_f.png'),
                                width: 31,
                                height: 32,
                              ),
                            )),
                        Expanded(
                          flex: 7,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 10, left: 4),
                              child: CupertinoTextField(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 0.5, color: Colors.grey),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(33)),
                                  controller: controller.messageController,
                                  placeholder: 'Message',
                                  suffix: IconButton(
                                      onPressed: () {
                                        controller.sendMessage;
                                        controller.scrollController!.animateTo(
                                            controller.scrollController!
                                                .position.maxScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 20),
                                            curve: Curves.ease);
                                      },
                                      icon: const Icon(Icons.send)))),
                        ),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/record4x.png'),
                                  width: 19,
                                  height: 27,
                                ),
                              ),
                              onTap: () => {},
                            ))
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
