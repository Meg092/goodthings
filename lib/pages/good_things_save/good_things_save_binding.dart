import 'package:get/get.dart';

import 'good_things_save_logic.dart';

class GoodThingsSaveBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      GoodThingsSaveLogic(),
      permanent: true,
    );
  }
}
