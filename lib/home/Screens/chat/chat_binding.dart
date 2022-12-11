import 'package:get/instance_manager.dart';
import 'package:telegram_clone/home/Screens/chat/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScrollControllerGetx>(() => ScrollControllerGetx());
  }
}
