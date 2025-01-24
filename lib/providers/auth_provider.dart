import 'package:flutter/material.dart';
import 'package:wartel_receiver/services/http_service.dart';

class AuthProvider with ChangeNotifier {
  final httpService = HttpService();

  Future<void> login() async {}
  Future<void> validateOtp() async {}
  Future<void> logout() async {}
  Future<void> me() async {}
  
  Future<bool> isAuth() async {
    try {
      await me();
      return false;
      // return true;
    } catch(_) {
      return false;
    }
  }
}