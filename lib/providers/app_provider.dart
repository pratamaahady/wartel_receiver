import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:wartel_receiver/services/http_service.dart';

class AppProvider with ChangeNotifier {
  final httpService = HttpService();

  String _version = "1.0.0";
  String get version => _version;

  String? _agoraAppId;
  String? get agoraAppId => _agoraAppId;

  Future getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    
    notifyListeners();
  }

  Future getSetting() async {
    final resp = await httpService.get('setting');
    _agoraAppId = resp.data['agoraAppId'];

    notifyListeners();
  }
}