import 'dart:math';

import 'package:get/get.dart';
import 'package:good_things/db_good_things/db_good_things.dart';
import 'package:good_things/db_good_things/good_things_entity.dart';
import 'package:flutter/material.dart';

class GoodThingsLuckyDrawController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final DB db = Get.find<DB>();
  final isLoading = false.obs;
  final isLottery = true.obs;
  final CheckInStats? checkInStats = Get.arguments as CheckInStats?;
  final luckyDraw = Rx<LuckyDrawEntity?>(null);

  late AnimationController animationController;
  late Animation<double> flipAnimation;

  @override
  void onInit() async {
    super.onInit();

    animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    flipAnimation = Tween<double>(begin: 0.0, end: 2.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  handleLuckyDraw() async {
    final random = Random();
    final index = random.nextInt(luckyDraws.length);
    final randomLuckyDraw = luckyDraws[index];

    final result = await db.createLuckyDraw(randomLuckyDraw);
    if (result >= 0) {
      luckyDraw.value = await db.getLuckyDrawById(result);
    }

    animationController.forward().then((_) {
      isLottery.value = !isLottery.value;
      animationController.reset();
    });
  }
}
