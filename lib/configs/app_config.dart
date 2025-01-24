import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  
  static String name = dotenv.env['APP_NAME'] ?? 'Glories Receiver';
  static String apiHost = dotenv.env['API_HOST'] ?? 'http://192.168.1.2:8000';
  static String agoraAppId = dotenv.env['AGORA_APP_ID'] ?? '';
}