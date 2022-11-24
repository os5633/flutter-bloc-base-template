import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:version/version.dart';

class AppUpdateUtils {
  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<Version> getLatestAppVersion() async {
    String latestAppVersion = remoteConfig.getString("latest_version");
    log('latest version: $latestAppVersion');
    return Version.parse(latestAppVersion);
  }

  static Future<Version> getMinAppVersion() async {
    String minAppVersion = remoteConfig.getString("min_version");
    log('min version: $minAppVersion');
    return Version.parse(minAppVersion);
  }

  static Future<Version> getCurrentAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version = packageInfo.version;
    log('current version: $version');
    return Version.parse(version);
  }

  static Future<UpdateType> checkUpdate() async {
    try {
      await remoteConfig.setDefaults({});
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 5),
          minimumFetchInterval: const Duration(seconds: 60),
        ),
      );
      await remoteConfig.fetchAndActivate();
      var currentAppVersion = await getCurrentAppVersion();
      var minAppVersion = await getMinAppVersion();
      var latestAppVersion = await getLatestAppVersion();

      log('-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-');
      log("-----AppUpdateUtils :: currentAppVersion -----$currentAppVersion");
      log("-----AppUpdateUtils :: minAppVersion -----$minAppVersion");
      log("-----AppUpdateUtils :: latestAppVersion -----$latestAppVersion");
      log('-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-');
      if (currentAppVersion < minAppVersion) {
        log("-----currentAppVersion < minAppVersion :: UpdateType.force-----");
        return UpdateType.force;
      }
      if (currentAppVersion < latestAppVersion) {
        log("-----currentAppVersion < latestAppVersion :: UpdateType.recommend-----");
        return UpdateType.recommend;
      }
      return UpdateType.none;
    } catch (e) {
      return UpdateType.none;
    }
  }
}

enum UpdateType { force, recommend, none }
