import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_things/db_good_things/good_things_entity.dart';
import 'package:good_things/main.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart';

class BuildCalendar extends StatefulWidget {
  final String month;
  final DateTime day;
  final Function(String) updateMonth;
  final Function(DateTime) updateDay;
  final List<GoodThingEntity> goodThings;

  const BuildCalendar({
    super.key,
    required this.month,
    required this.day,
    required this.updateMonth,
    required this.updateDay,
    required this.goodThings,
  });

  @override
  State<BuildCalendar> createState() => _BuildCalendarState();
}

class _BuildCalendarState extends State<BuildCalendar> {
  final EventList<Event> _markedDateMap = EventList<Event>(events: {});
  DateTime? _lastUpdatedMonth;

  update(DateTime? day) {
    _markedDateMap.clear();

    Set<DateTime> checkInDates = {};

    for (var g in widget.goodThings) {
      final date = g.createdTime!;
      final checkInDate = DateTime(date.year, date.month, date.day);
      checkInDates.add(checkInDate);
    }

    for (var date in checkInDates) {
      _markedDateMap.add(
        date,
        Event(
          date: date,
          icon: const Icon(Icons.person),
          dot: _dot(isSelect: isSameDate(day ?? widget.day, date)),
        ),
      );
    }
  }

  isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  @override
  void didUpdateWidget(BuildCalendar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.month != widget.month ||
        oldWidget.goodThings != widget.goodThings) {
      update(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final [year, month] = widget.month.split('-');

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      height: 330.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Stack(
        children: [
          CalendarCarousel<Event>(
            onCalendarChanged: (DateTime date) {
              final dateFormat = DateFormat('yyyy-MM');
              final newMonth = dateFormat.format(date);
              if (_lastUpdatedMonth == null ||
                  newMonth != dateFormat.format(_lastUpdatedMonth!)) {
                _lastUpdatedMonth = date;
                widget.updateMonth(newMonth);
              }
            },
            isScrollable: false,
            onDayPressed: (DateTime date, List<Event> events) {
              widget.updateDay(date);
              update(date);
            },
            weekendTextStyle: TextStyle(
              color: Color(0xFF0F0F0F),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            prevDaysTextStyle: TextStyle(
              color: Color(0xFFC1C1C1),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            nextDaysTextStyle: TextStyle(
              color: Color(0xFFC1C1C1),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            daysTextStyle: TextStyle(
              color: Color(0xFF0F0F0F),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            todayButtonColor: Colors.transparent,
            todayBorderColor: Colors.transparent,
            todayTextStyle: TextStyle(
              color: Color(0xFF0F0F0F),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            selectedDayTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
            selectedDayBorderColor: Colors.transparent,
            selectedDayButtonColor: primaryColor,
            daysHaveCircularBorder: true,
            weekDayMargin: EdgeInsets.only(top: 6.h, bottom: 8.h),
            weekdayTextStyle: TextStyle(
              color: Color(0xFF0F0F0F),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
            showHeader: true,
            headerMargin: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
            headerText: "$year-${month.padLeft(2, '0')}",
            headerTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
            leftButtonIcon: Image.asset(
              'assets/left.png',
              width: 19.w,
              height: 19.h,
            ),
            rightButtonIcon: Image.asset(
              'assets/right.png',
              width: 19.w,
              height: 19.h,
            ),
            customDayBuilder: (
              bool isSelectable,
              int index,
              bool isSelectedDay,
              bool isToday,
              bool isPrevMonthDay,
              TextStyle textStyle,
              bool isNextMonthDay,
              bool isThisMonthDay,
              DateTime day,
            ) {
              return null;
            },
            markedDatesMap: _markedDateMap,
            height: 320.0,
            selectedDateTime: widget.day,
            iconColor: Colors.black,
          ),
          Positioned(
            top: 38.h,
            left: 0,
            right: 0,
            child: Divider(
              color: Colors.grey.shade200,
            ).paddingSymmetric(horizontal: 8.w),
          ),
        ],
      ),
    );
  }
}

Widget _dot({required bool isSelect}) {
  return Transform.translate(
    offset: Offset(1.w, 2.h),
    child: Container(
      height: 6.h,
      width: 6.w,
      decoration: BoxDecoration(
        color: isSelect ? Colors.white : primaryColor,
        borderRadius: BorderRadius.circular(50.r),
      ),
    ),
  );
}
