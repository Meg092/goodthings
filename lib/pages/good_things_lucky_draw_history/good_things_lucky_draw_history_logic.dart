import 'package:get/get.dart';
import 'package:good_things/db_good_things/db_good_things.dart';
import 'package:good_things/db_good_things/good_things_entity.dart';

class GoodThingsLuckyDrawHistoryController extends GetxController {
  final DB db = Get.find<DB>();
  Rx<List<LuckyDrawEntity>> luckyDraws = Rx<List<LuckyDrawEntity>>([]);

  @override
  void onInit() async {
    super.onInit();
    luckyDraws.value = await db.getAllLuckyDraws();
  }
}
