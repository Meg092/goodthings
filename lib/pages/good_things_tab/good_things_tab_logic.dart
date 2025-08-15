import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../main.dart';

class GoodThingsTabController extends GetxController {
  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void changeTabIndex(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
    var routeName = '';
    switch (index) {
      case 0:
        routeName = '/good_things_home';
        break;
      case 1:
        routeName = '/good_things_history';
        break;
      case 2:
        routeName = '/good_things_setting';
        break;
      default:
        routeName = '/good_things_home';
    }
    Get.offNamed(routeName, id: 1);
  }


  Widget getPage(String? routeName) {
    if (routeName == '/') {
      routeName = '/good_things_home';
    }
    final page = Things.firstWhere(
      (element) => element.name == routeName,
    );
    return page.page();
  }

  Bindings? getBinding(String? routeName) {
    if (routeName == '/') {
      routeName = '/good_things_home';
    }
    final page = Things.firstWhere(
      (element) => element.name == routeName,
    );
    return page.binding;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
