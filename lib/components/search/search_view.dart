import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:telegram_clone/components/search/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField();
  }
}
