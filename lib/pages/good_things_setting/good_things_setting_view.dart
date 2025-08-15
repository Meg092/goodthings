import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:styled_widget/styled_widget.dart';

import 'good_things_setting_logic.dart';

class GoodThingsSettingPage extends GetView<GoodThingsSettingController> {
  const GoodThingsSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.0872, -0.9962),
                end: Alignment(-0.0872, 0.9962),
                colors: [Color(0xFFAACBFF), Color(0xFFF8F8F8)],
                stops: [0.0, 225.h / 400.h],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 62.h),
                Text(
                  "Setting",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 34.sp,
                    color: Color(0xFF0F0F0F),
                    fontWeight: FontWeight.bold,
                  ),
                ).paddingOnly(left: 8.w),
                SizedBox(height: 16.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 12.h,
                    horizontal: 24.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Text(
                          'View history',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF0F0F0F),
                          ),
                        ).padding(vertical: 6.h),
                      ).gestures(
                        onTap:
                            () =>
                                Get.toNamed('/good_things_history'),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Text(
                          'View lucky draw history',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF0F0F0F),
                          ),
                        ).padding(vertical: 6.h),
                      ).gestures(
                        onTap:
                            () => Get.toNamed(
                              '/good_things_lucky_draw_history',
                            ),
                      ),
                      Divider(),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Text(
                          'Delete all history',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Color(0xFF0F0F0F),
                          ),
                        ).padding(vertical: 6.h),
                      ).gestures(onTap: () => controller.clearRecords(context)),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Version',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF0F0F0F),
                            ),
                          ),
                          Text(
                            'v1.0.0',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Color(0xFF0F0F0F),
                            ),
                          ),
                        ],
                      ).padding(vertical: 6.h),
                    ],
                  ),
                ).gestures(onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
