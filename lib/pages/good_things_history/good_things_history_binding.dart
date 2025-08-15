import 'package:get/get.dart';
import './good_things_history_logic.dart';

class GoodThingsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsHistoryController());
  }
}
