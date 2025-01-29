import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/components/app_layout.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/providers/auth_provider.dart';
import 'package:wartel_receiver/screens/login_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ super.key });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthProvider authProvider;

  bool isLoading = false;

  @override
  initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  logout() {
    setState(() {
      isLoading = true;
    });
    authProvider.logout().then((resp) {
      redirectTo(context, const LoginScreen());
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      isLoading: isLoading,
      backgroundColor: ThemeConfig.primaryAccentColor,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: size(context).width * .8,
          decoration: BoxDecoration(
            color: ThemeConfig.backgroundColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.white12,
                blurRadius: 10,
                offset: Offset(0,5),
                spreadRadius: 10
              )
            ],
          ),
          child: Consumer<AuthProvider>(
            builder: (context, value, child) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AppLogo(height: 60),
                const SizedBox(height: 50),
                const CircleAvatar(
                  backgroundColor: ThemeConfig.primaryColor,
                  foregroundColor: ThemeConfig.backgroundColor,
                  radius: 30,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 10),
                Text(value.user?.name ?? '-', style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )),
                Text(value.user?.phoneNumber ?? '-', style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54
                )),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      minRadius: 5,
                      maxRadius: 5,
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text('Aktif', style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.green
                    )),
                  ]
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: logout,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white
                    ),
                    child: Text('Keluar'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}