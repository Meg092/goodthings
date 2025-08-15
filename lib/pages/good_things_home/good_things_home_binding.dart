import 'package:get/get.dart';
import 'package:good_things/pages/good_things_home/good_things_home_logic.dart';

class GoodThingsHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsHomeController());
  }
}
