import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc_base_template/common/common.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CustomInterceptors extends Interceptor {
  final FirebaseAuth fireAuth = FirebaseAuth.instance;
  Map<String, String> platformHeader = <String, String>{};

  String encode(String str) {
    return utf8.fuse(base64).encode(str);
  }

  Future<void> _getPlatformHeader() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      platformHeader = {
        "X-Platform": "IOS",
        "X-Platform-Version": iosInfo.systemVersion.toString(),
        "X-App-Version": packageInfo.version,
        "X-App-Build-Number": packageInfo.buildNumber,
        "X-Device-Unique-Id":
            "${encode("IFA")}.${encode(iosInfo.identifierForVendor ?? "")}",
      };
    } else if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      platformHeader = {
        "X-Platform": "ANDROID",
        "X-Platform-Version": androidInfo.version.sdkInt.toString(),
        "X-App-Version": packageInfo.version,
        "X-App-Build-Number": packageInfo.buildNumber,
        "X-Device-Unique-Id":
            "${encode("GAID")}.${encode(androidInfo.fingerprint)}",
      };
    }
  }

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    log('REQUEST[${options.method}] => ${options.method}: ${options.path}');

    final idToken = await fireAuth.currentUser?.getIdToken();
    log("$idToken", name: "AUTHORIZATION ID TOKEN");
    if (idToken != null) {
      options.headers.addAll({
        "authorization": "Bearer $idToken",
      });
    }
    await _getPlatformHeader();
    options.headers.addAll({
      "Accept-Language": "ko",
      ...platformHeader,
    });

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE[${response.statusCode}] => ${response.requestOptions.method}: ${response.requestOptions.path}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    log('ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}');
    log('ERROR :: error.response?.data :: ${error.type} ');
    if ((error.response?.statusCode == 403) && fireAuth.currentUser != null) {
      fireAuth.currentUser!.isAnonymous ? null : fireAuth.signOut();
    }
    return super.onError(error, handler);
  }
}
