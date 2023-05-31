import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void printPackageinfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;

  debugPrint('App Name: $appName');
  debugPrint('Package Name: $packageName');
  debugPrint('Version: $version');
  debugPrint('Build Number: $buildNumber');
}

Future<String> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
