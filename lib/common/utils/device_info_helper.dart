import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoHelper {
  static DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static IosDeviceInfo? iosInfo;
  static AndroidDeviceInfo? androidInfo;

  static Future<void> init() async {
    if (Platform.isIOS) {
      iosInfo = await deviceInfoPlugin.iosInfo;
    } else {
      androidInfo = await deviceInfoPlugin.androidInfo;
    }
  }
}
