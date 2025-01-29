import 'package:flutter/material.dart';
import 'package:wartel_receiver/models/user.dart';
import 'package:wartel_receiver/services/firebase_service.dart';
import 'package:wartel_receiver/services/http_service.dart';

class AuthProvider with ChangeNotifier {
  final httpService = HttpService();
  final firebaseService = FirebaseService();

  User? _user;
  User? get user => _user;

  Future<HttpResponse> login(String name, String phoneNumber) async {
    final resp = await httpService.post('auth/login', {
      "name": name,
      "phoneNumber": phoneNumber
    });

    _user = User.fromJson(resp.data);
    notifyListeners();

    return resp;
  }

  Future<HttpResponse> resendOtp(String phoneNumber) async {
    final resp = await httpService.post('auth/send-otp', {
      "phoneNumber": phoneNumber
    });

    return resp;
  }

  Future<HttpResponse> validateOtp(String phoneNumber, String otp) async {
    // final fcmToken = await firebaseService.messaging.getToken();
    final fcmToken = 'FCMToken';
    final resp = await httpService.post('auth/otp', {
      "phoneNumber": phoneNumber,
      "otp": otp,
      "fcmToken": fcmToken
    });
    await httpService.setAccessToken(resp.data['access_token']);

    return resp;
  }

  Future logout() async {
    await httpService.delete('auth/logout');
    await httpService.removeAccessToken();
    _user = null;

    notifyListeners();

  }
  
  Future<void> me() async {
    try {
      final resp = await httpService.get('auth/me');

      _user = User.fromJson(resp.data);
      notifyListeners();
    } catch(err) {
      _user = null;
      notifyListeners();

      rethrow;
    }
  }
  
  Future<bool> isAuth() async {
    try {
      await me();
      return true;
    } catch(_) {
      return false;
    }
  }
}