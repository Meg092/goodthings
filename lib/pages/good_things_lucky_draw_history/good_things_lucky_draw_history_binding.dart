import 'package:get/get.dart';
import 'good_things_lucky_draw_history_logic.dart';

class GoodThingsLuckyDrawHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsLuckyDrawHistoryController());
  }
}
