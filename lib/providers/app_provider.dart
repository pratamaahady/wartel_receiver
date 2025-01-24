import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppProvider with ChangeNotifier {
  String _version = "1.0.0";
  String get version => _version;

  Future getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;

    notifyListeners();
  }
}