import 'package:flutter/material.dart';
import 'package:wartel_receiver/components/app_layout.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/screens/login_otp_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      backgroundColor: ThemeConfig.primaryAccentColor,
      bottomSheet: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: ThemeConfig.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40)
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selamat Datang', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )),
            const Text('Masuk untuk melanjutkan', style: TextStyle(
              color: Colors.black54,
              fontSize: 13
            )),
            const SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nama Lengkap'
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                hintText: 'Nomor Telepon',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){
                  redirectTo(context, const LoginOtpScreen());
                },
                style: TextButton.styleFrom(
                  backgroundColor: ThemeConfig.primaryColor,
                  foregroundColor: ThemeConfig.backgroundColor,
                ),
                child: const Text('Masuk'),
              ),
            ),
          ],
        ),
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Column(
            children: [
              AppLogo(height: 60),
            ]
          ),
        ),
      ),
    );
  }
}