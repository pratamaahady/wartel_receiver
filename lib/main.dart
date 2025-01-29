import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/configs/app_config.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/providers/app_provider.dart';
import 'package:wartel_receiver/providers/auth_provider.dart';
import 'package:wartel_receiver/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(create: (_) => AppProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: const App(),
    )
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.name,
      theme: ThemeConfig.themeData,
      home: const SplashScreen(),
    );
  }
}
