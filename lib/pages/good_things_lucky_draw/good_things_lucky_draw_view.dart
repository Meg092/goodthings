import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:good_things/main.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'good_things_lucky_draw_logic.dart';

class GoodThingsLuckyDrawPage extends GetView<GoodThingsLuckyDrawController> {
  const GoodThingsLuckyDrawPage({super.key});

  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.0872, -0.9962),
            end: Alignment(-0.0872, 0.9962),
            colors: [Color(0xFFAACBFF), Color(0xFFF8F8F8)],
            stops: [0.0, 0.22],
          ),
        ),
        child: SingleChildScrollView(
          child: <Widget>[
            SizedBox(height: 46.h),
            Icon(
              Icons.chevron_left,
              size: 30.0,
            ).paddingOnly(left: 8.w).gestures(onTap: () => Get.back()),
            <Widget>[
              Image.asset(
                'assets/star_three.png',
                width: 74.w,
                height: 65.h,
              ).center(),
              SizedBox(height: 4.h),
              Text(
                "Blessings Abound",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 34.sp,
                  color: Color(0xFF0F0F0F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 21.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child:
                    <Widget>[
                      Image.asset(
                        'assets/calendar.png',
                        width: 23.w,
                        height: 23.h,
                      ),
                      SizedBox(width: 4.w),
                      Text('Check-in Daily: ${controller.checkInStats?.streak}')
                          .textColor(Colors.white)
                          .fontSize(14.sp)
                          .fontWeight(FontWeight.w500),
                      SizedBox(width: 32.w),
                      Image.asset(
                        'assets/record.png',
                        width: 23.w,
                        height: 23.h,
                      ),
                      SizedBox(width: 4.w),
                      Text('record: ${controller.checkInStats?.recordCount}')
                          .textColor(Colors.white)
                          .fontSize(14.sp)
                          .fontWeight(FontWeight.w500),
                    ].toRow(),
              ),
              SizedBox(height: 24.h),
              Text(
                    "Click the Star Below for Today's Lucky Draw",
                    textAlign: TextAlign.center,
                  )
                  .fontSize(24.sp)
                  .fontWeight(FontWeight.bold)
                  .textColor(Color(0xFF0F0F0F)),
              SizedBox(height: 40.h),
              Obx(
                () => Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 240.h,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: SizedBox.shrink(),
                    ),
                    controller.isLottery.value
                        ? SizedBox(
                          height: 240.h,
                          child: AnimatedBuilder(
                            animation: controller.flipAnimation,
                            builder: (context, child) {
                              return Transform(
                                alignment: Alignment.center,
                                transform:
                                    Matrix4.identity()
                                      ..setEntry(3, 2, 0.001)
                                      ..rotateY(
                                        controller.flipAnimation.value *
                                            3.14159,
                                      ),
                                child: Image.asset(
                                      'assets/star.png',
                                      width: 86.w,
                                      height: 86.h,
                                    )
                                    .paddingOnly(top: 20.h, bottom: 20.h)
                                    .center()
                                    .gestures(
                                      onTap: () => controller.handleLuckyDraw(),
                                    ),
                              );
                            },
                          ),
                        )
                        : Transform.translate(
                          offset: Offset(0, 11.h),
                          child: Container(
                            width: double.infinity,
                            height: 240.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child:
                                <Widget>[
                                  SizedBox(height: 22.h),
                                  Text(dateFormat.format(date))
                                      .textColor(Color(0xFFA2A2A2))
                                      .fontSize(14.sp)
                                      .fontWeight(FontWeight.w500),
                                  SizedBox(height: 6.h),
                                  Text(controller.luckyDraw.value?.title ?? '')
                                      .textColor(Color(0xFF0F0F0F))
                                      .fontSize(28.sp)
                                      .fontWeight(FontWeight.bold),
                                  SizedBox(height: 8.h),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 23.w,
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF2F7FF),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    constraints: BoxConstraints(
                                      minHeight: 56.h,
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller
                                                .luckyDraw
                                                .value
                                                ?.description ??
                                            '',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF0F0F0F),
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].toColumn(),
                          ),
                        ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
            ].toColumn().paddingSymmetric(horizontal: 16.w),
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ),
      ),
    );
  }
}
