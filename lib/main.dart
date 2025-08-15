import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:good_things/pages/good_things_history/good_things_history_binding.dart';
import 'package:good_things/pages/good_things_history/good_things_history_view.dart';
import 'package:good_things/pages/good_things_home/good_things_hmp.dart';
import 'package:good_things/pages/good_things_home/good_things_home_binding.dart';
import 'package:good_things/pages/good_things_home/good_things_home_view.dart';
import 'package:good_things/pages/good_things_lucky_draw/good_things_lucky_draw_binding.dart';
import 'package:good_things/pages/good_things_lucky_draw/good_things_lucky_draw_view.dart';
import 'package:good_things/pages/good_things_lucky_draw_history/good_things_lucky_draw_history_binding.dart';
import 'package:good_things/pages/good_things_lucky_draw_history/good_things_lucky_draw_history_view.dart';
import 'package:good_things/pages/good_things_save/good_things_save_binding.dart';
import 'package:good_things/pages/good_things_save/good_things_save_view.dart';
import 'package:good_things/pages/good_things_setting/good_things_setting_binding.dart';
import 'package:good_things/pages/good_things_setting/good_things_setting_view.dart';
import 'package:good_things/pages/good_things_tab/good_things_tab_binding.dart';
import 'package:good_things/pages/good_things_tab/good_things_tab_view.dart';

import 'db_good_things/db_good_things.dart';

Color primaryColor = const Color(0xFF2282F2);
Color bgColor = const Color(0xFFF8F8F8);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Get.putAsync(() => DB().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: Things,
          initialRoute: '/',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            colorScheme: ColorScheme.light(primary: primaryColor),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            dividerTheme: DividerThemeData(
              thickness: 1,
              color: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }
}
List<GetPage<dynamic>> Things = [
  GetPage(
    name: '/',
    page: () => GoodThingsSaveView(),
    binding: GoodThingsSaveBinding(),
  ),
  GetPage(
    name: '/good_things_tab',
    page: () => GoodThingsTabPage(),
    binding: GoodThingsTabBinding(),
  ),
  GetPage(
    name: '/good_things_home',
    page: () => GoodThingsHomePage(),
    binding: GoodThingsHomeBinding(),
  ),
  GetPage(
    name: '/good_things_lucky_draw',
    page: () => GoodThingsLuckyDrawPage(),
    binding: GoodThingsLuckyDrawBinding(),
  ),
  GetPage(
    name: '/good_things_hp',
    page: () => GoodThingsHmp(),
  ),
  GetPage(
    name: '/good_things_history',
    page: () => GoodThingsHistoryPage(),
    binding: GoodThingsHistoryBinding(),
  ),
  GetPage(
    name: '/good_things_lucky_draw_history',
    page: () => GoodThingsLuckyDrawHistoryPage(),
    binding: GoodThingsLuckyDrawHistoryBinding(),
  ),
  GetPage(
    name: '/good_things_setting',
    page: () => GoodThingsSettingPage(),
    binding: GoodThingsSettingBinding(),
  ),
];