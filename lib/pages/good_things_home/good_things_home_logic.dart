import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:good_things/db_good_things/db_good_things.dart';
import 'package:good_things/db_good_things/good_things_entity.dart';

class GoodThingsHomeController extends GetxController {
  final DB db = Get.find<DB>();

  Rx<CheckInStats> checkInStats = Rx<CheckInStats>(
    CheckInStats(recordCount: 0, streak: 0),
  );
  Rx<List<GoodThingEntity>> goodThings = Rx<List<GoodThingEntity>>([]);
  final note = ''.obs;
  final month = ''.obs;
  final isLoading = false.obs;
  Rx<DateTime> day = Rx<DateTime>(DateTime.now());
  Rx<List<GoodThingEntity>> dayGoodThings = Rx<List<GoodThingEntity>>([]);

  final luckyDraw = Rx<LuckyDrawEntity?>(null);

  initGoodThings() async {
    final [sYear, sMonth] = month.value.split('-');
    goodThings.value = await db.getByMonth(sYear, sMonth);
  }

  submitNote() async {
    if (note.value == '') {
      Fluttertoast.showToast(msg: 'No text entered.');
      return;
    }
    await db.create(GoodThingEntity(note: note.value));
    await updateCheckInStats();
    await initGoodThings();
    await updateDay(day.value);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Fluttertoast.showToast(msg: 'Saved successfully.');

    if (luckyDraw.value == null) {
      await Get.toNamed(
        '/good_things_lucky_draw',
        arguments: checkInStats.value,
      );
      await getLuckyDrawByDate();
    }
    return;
  }

  updateMonth(String d) async {
    month.value = d;

    await initGoodThings();
  }

  updateCheckInStats() async {
    note.value = '';
    checkInStats.value = await db.getConsecutiveCheckInDays();
  }

  updateDay(DateTime d) async {
    isLoading.value = true;
    day.value = d;

    dayGoodThings.value =
        goodThings.value.where((g) => isSameDate(g.createdTime!, d)).toList();

    if (dayGoodThings.value.isNotEmpty) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    isLoading.value = false;
  }

  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  getLuckyDrawByDate() async {
    final currentDate = DateTime.now();
    final date =
        '${currentDate.year}-${currentDate.month.toString().padLeft(2, '0')}-${currentDate.day.toString().padLeft(2, '0')}';
    luckyDraw.value = await db.getLuckyDrawByDate(date);
  }

  @override
  void onInit() async {
    super.onInit();
    DateTime now = DateTime.now();
    month.value = '${now.year}-${now.month}';
    await initGoodThings();
    await updateCheckInStats();

    dayGoodThings.value =
        goodThings.value
            .where((g) => isSameDate(g.createdTime!, day.value))
            .toList();

    await getLuckyDrawByDate();
  }
}
