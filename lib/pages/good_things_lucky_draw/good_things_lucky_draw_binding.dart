import 'package:get/get.dart';
import 'good_things_lucky_draw_logic.dart';

class GoodThingsLuckyDrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsLuckyDrawController());
  }
}
