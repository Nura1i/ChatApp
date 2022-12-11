import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telegram_clone/services/fire_service.dart';
import 'package:uuid/uuid.dart';

import '../../../components/user_widget/model/message_model.dart';

class ScrollControllerGetx extends GetxController {
  final ScrollController? scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();

  bool? isVisible = true;
  double? _currentPosition = 0;
  void get listenScroll {
    try {
      scrollController!.addListener(listener);
    } catch (e) {
      log(e.toString());
    }
  }

  void listener() {
    if (scrollController!.position.pixels ==
        scrollController!.position.minScrollExtent) {
      isVisible = true;
    } else if (_currentPosition! > scrollController!.position.pixels) {
      isVisible = true;
    } else if (_currentPosition! < scrollController!.position.pixels) {
      isVisible = false;
    }
    _currentPosition = scrollController!.position.pixels;
    debugPrint(
        " current:::${_currentPosition.toString()}  scroll::${scrollController!.position.pixels}");
  }

  @override
  void dispose() {
    scrollController!.removeListener(listener);
    super.dispose();
  }

  String? mess;

  void get sendMessage async {
    try {
      final id = const Uuid().v1();
      MessageModel myMessage = MessageModel(
          id: id,
          text: messageController.text,
          publishedDate: DateTime.now(),
          userId: FirebaseAuth.instance.currentUser!.uid);

      final messageSend =
          await FireDatabaseService.sendMssage(message: myMessage);
      if (messageSend!) {
        debugPrint('SEND');
        messageController.clear();

        mess = myMessage.text;
      }
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
}
