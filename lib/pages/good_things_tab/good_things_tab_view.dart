import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_things/main.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';
import 'good_things_tab_logic.dart';

class GoodThingsTabPage extends GetView<GoodThingsTabController> {
  const GoodThingsTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        onGenerateRoute:
            (settings) => GetPageRoute(
              settings: settings,
              page: () => controller.getPage(settings.name),
              binding: controller.getBinding(settings.name),
              transition: Transition.fade,
            ),
      ),
      bottomNavigationBar: Obx(() => _bottomNavBar(context)),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 90.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _NavIcon(
                label: 'home',
                iconAsset: 'assets/tabs/home.png',
                activeIconAsset: 'assets/tabs/home_active.png',
                selected: controller.currentIndex.value == 0,
                onTap: () => controller.changeTabIndex(0),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                width: 66.w,
                height: 66.h,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Image.asset('assets/tabs/dashboard.jpg'),
              ).gestures(onTap: () => _buildDashboard(context)),
              _NavIcon(
                label: 'setting',
                iconAsset: 'assets/tabs/setting.png',
                activeIconAsset: 'assets/tabs/setting_active.png',
                selected: controller.currentIndex.value == 2,
                onTap: () => controller.changeTabIndex(2),
              ),
            ],
          ),
        )
        .backgroundColor(Colors.white)
        .boxShadow(
          color: const Color.fromARGB(255, 43, 43, 43).withOpacity(0.1),
          spreadRadius: 2,
          blurRadius: 4,
          offset: Offset(0, -2),
        );
  }
}

class _NavIcon extends StatefulWidget {
  final String label;
  final String iconAsset;
  final String activeIconAsset;
  final bool selected;
  final VoidCallback onTap;

  const _NavIcon({
    required this.label,
    required this.iconAsset,
    required this.activeIconAsset,
    required this.selected,
    required this.onTap,
  });

  @override
  _NavIconState createState() => _NavIconState();
}

class _NavIconState extends State<_NavIcon> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Material(
        color: Colors.transparent,
        child: InkResponse(
          onTap: widget.onTap,
          splashColor: Colors.black.withOpacity(0.1),
          highlightColor: Colors.black.withOpacity(0.1),
          containedInkWell: true,
          radius: 80.0,
          splashFactory: InkRipple.splashFactory,
          customBorder: const CircleBorder(),
          child: Container(
            width: 60.w,
            height: 60.h,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  width: 22.w,
                  height: 22.h,
                  widget.selected ? widget.activeIconAsset : widget.iconAsset,
                  fit: BoxFit.cover,
                ),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontWeight:
                        widget.selected ? FontWeight.w600 : FontWeight.w500,
                    color:
                        widget.selected
                            ? Theme.of(context).primaryColor
                            : const Color(0xFF292929),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _buildDashboard(BuildContext context) {
  final date = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');

  showDialog<void>(
    context: context,
    barrierColor: Color.fromRGBO(0, 0, 0, 0.8),
    builder: (BuildContext context) {
      return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/dashboard_bg.png',
                  width: 272.w,
                  height: 266.h,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 42.h),
                    Text(
                      "Blessings",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F0F0F),
                      ),
                    ),
                    Text(
                      "Abound",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F0F0F),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Text(
                      dateFormat.format(date),
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Color(0xFF8E8E8E),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
          .gestures(
            onTap: () {
              Navigator.of(context).pop();
            },
          )
          .marginOnly(bottom: 142.h);
    },
  );
}
