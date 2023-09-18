


import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:vnedu/modal/intro_infor.dart';


class DeviceId {
  static const String PREFS_DEVICE_ID = "device_id";
  static late String uuid;

  static Future<void> init() async{
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if(Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      String androidId = androidDeviceInfo.id;
      if (androidId != "9774d56d682e549c") {
        uuid = Uuid().v5(Uuid.NAMESPACE_URL, androidId);
      }else {
        uuid = Uuid().v4();
      }
    }else if(Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      uuid = iosDeviceInfo.identifierForVendor!;
    }
  }

  static getDeviceId() {
    return uuid;
  }

}

