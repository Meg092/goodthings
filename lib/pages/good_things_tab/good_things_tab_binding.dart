import 'package:get/get.dart';

import 'good_things_tab_logic.dart';

class GoodThingsTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsTabController());
  }
}
