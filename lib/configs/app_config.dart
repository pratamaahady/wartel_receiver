import 'package:flutter/material.dart';

class AppConfig {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  
  static String name = 'Glories Receiver';
  static String apiHost = 'http://192.168.1.2';
}