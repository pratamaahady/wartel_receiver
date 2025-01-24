import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/providers/app_provider.dart';
import 'package:wartel_receiver/providers/auth_provider.dart';
import 'package:wartel_receiver/screens/home_screen.dart';
import 'package:wartel_receiver/screens/login_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ super.key });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AppProvider appProvider;
  late AuthProvider authProvider;

  bool isLoading = true;
  bool isError = false;
  String? errMsg;

  @override
  void initState() {
    super.initState();
    appProvider = Provider.of<AppProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);

    initApp();
  }

  Future<void> initApp() async {
    try {
      setState((){
        isLoading = true;
        isError = false;
      });

      await appProvider.getInfo();
      await requestPermission();
      authProvider.isAuth().then((isAuth) {
        if(isAuth) {
          redirectTo(context, const HomeScreen());
        } else {
          redirectTo(context, const LoginScreen());
        }
      });
    } catch(_) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Future<void> requestPermission() async {
    final permissions = [
      Permission.phone,
      Permission.camera,
      Permission.microphone,
      Permission.notification,
      Permission.bluetooth,
    ];
    
    final permissionStatuses = await permissions.request();
    if(permissionStatuses.containsValue(PermissionStatus.denied)) {
      throw Error();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppLogo(width: size(context).width * .5),
                    const SizedBox(height: 20),
                    Visibility(
                      visible: isLoading,
                      child: const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isError,
                      child: SizedBox(
                        width: size(context).width * .4,
                        child: TextButton(
                          onPressed: initApp, 
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black12,
                            foregroundColor: Colors.black54,
                            padding: const EdgeInsets.all(10),
                            minimumSize: const Size(20, 10),
                            textStyle: const TextStyle(
                              fontSize: 12
                            )
                          ),
                          child: const Text('Refresh')
                        ),
                      )
                    ),
                  ]
                ),
              ),
              const Column(
                children: [
                  Text('Powered by'),
                  Text('Pasti Juara', style: TextStyle(
                    fontSize: 20,
                    height: 1,
                    fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}