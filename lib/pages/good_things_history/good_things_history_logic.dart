import 'package:get/get.dart';
import 'package:good_things/db_good_things/db_good_things.dart';
import 'package:good_things/db_good_things/good_things_entity.dart';

class GoodThingsHistoryController extends GetxController {
  final DB db = Get.find<DB>();
  Rx<List<GoodThingEntity>> goodThings = Rx<List<GoodThingEntity>>([]);

  @override
  void onInit() async {
    super.onInit();
    goodThings.value = await db.getAll();
  }
}
