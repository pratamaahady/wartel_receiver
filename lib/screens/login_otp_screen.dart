import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:wartel_receiver/components/app_layout.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/screens/home_screen.dart';
import 'package:wartel_receiver/screens/login_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class LoginOtpScreen extends StatefulWidget {
  const LoginOtpScreen({ super.key });

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
      onPop: () {
        redirectTo(context, const LoginScreen());
      },
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
            const Text('Kode Verifikasi', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            )),
            SizedBox(
              width: size(context).width * .7,
              child: const Text('Masukkan Kode OTP yang telah kami kirimkan ke Whatsapp anda.', 
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 13
                )
              ),
            ),
            const SizedBox(height: 20),
            OtpTextField(
              autoFocus: true,
              borderColor: ThemeConfig.primaryColor,
              focusedBorderColor: ThemeConfig.primaryColor,
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: (){},
              child: const Text('Kirim ulang ( 30 )', style: TextStyle(
                fontSize: 14,
                color: ThemeConfig.textColor
              )),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: (){
                  redirectTo(context, const HomeScreen());
                },
                style: TextButton.styleFrom(
                  backgroundColor: ThemeConfig.primaryColor,
                  foregroundColor: ThemeConfig.backgroundColor,
                ),
                child: const Text('Verifikasi'),
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