import 'package:get/get.dart';
import 'package:good_things/pages/good_things_setting/good_things_setting_logic.dart';

class GoodThingsSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoodThingsSettingController());
  }
}
