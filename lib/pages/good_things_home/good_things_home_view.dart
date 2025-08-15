import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_things/main.dart';
import 'package:good_things/pages/good_things_home/good_things_calendar.dart';
import 'package:good_things/pages/good_things_home/good_things_text_field.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'good_things_home_logic.dart';

class GoodThingsHomePage extends GetView<GoodThingsHomeController> {
  const GoodThingsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(0.0872, -0.9962),
                    end: Alignment(-0.0872, 0.9962),
                    colors: [Color(0xFFAACBFF), Color(0xFFF8F8F8)],
                    stops: [0.0, 1.0],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 62.h),
                    Text(
                      "Blessings Abound",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 34.sp,
                        color: Color(0xFF0F0F0F),
                        fontWeight: FontWeight.bold,
                      ),
                    ).paddingOnly(left: 8.w),
                    SizedBox(height: 16.h),
                    Obx(
                      () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatCard(
                                '${controller.checkInStats.value.streak} days',
                                'Continuous check-in',
                              ),
                              _buildStatCard(
                                '${controller.checkInStats.value.recordCount} items',
                                'Record life',
                              ),
                            ],
                          )
                          .padding(horizontal: 16.w)
                          .decorated(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(45.r),
                          )
                          .height(88.h)
                          .alignment(Alignment.center),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              Obx(
                () =>
                    controller.luckyDraw.value != null
                        ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 16.w),
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
                            ),
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: Color(0xFF2196F3),
                                  borderRadius: BorderRadius.circular(18.r),
                                ),
                                child: Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 18.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.luckyDraw.value!.title,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      controller.luckyDraw.value!.description,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Color(0xFF666666),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ).paddingOnly(bottom: 12.h)
                        : SizedBox(),
              ),
              Obx(
                () => Container(
                  height: 154.h,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 2.w, color: Color(0xFF258AFF)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: GoodThingsTextField(
                          hintText: "Note Today's Daily Moments",
                          value: controller.note.value,
                          onChange: (v) => controller.note.value = v,
                          keyboardType: TextInputType.text,
                          minLines: 3,
                          maxLines: 5,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: controller.submitNote,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => BuildCalendar(
                  month: controller.month.value,
                  day: controller.day.value,
                  updateMonth: controller.updateMonth,
                  updateDay: controller.updateDay,
                  goodThings: controller.goodThings.value,
                ),
              ),
              SizedBox(height: 9.h),
              Obx(
                () =>
                    controller.isLoading.value
                        ? SizedBox(
                          height: 400.h,
                          child: Center(child: CircularProgressIndicator()),
                        )
                        : Container(
                          constraints: BoxConstraints(minHeight: 40.h),
                          child: Column(
                            children: [
                              ...controller.dayGoodThings.value.map((good) {
                                return _buildRecordCard(
                                  good.createdTime!,
                                  good.note,
                                );
                              }),
                            ],
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ).expanded();
  }

  Widget _buildRecordCard(DateTime date, String note) {
    final dateFormat = DateFormat('yyyy-MM-dd');

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateFormat.format(date),
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            note,
            style: TextStyle(fontSize: 14.sp, color: Color(0xFF5D5D5D)),
          ),
        ],
      ),
    );
  }
}
