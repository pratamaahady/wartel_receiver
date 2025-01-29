import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/components/app_layout.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/components/input_otp.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/providers/auth_provider.dart';
import 'package:wartel_receiver/screens/home_screen.dart';
import 'package:wartel_receiver/screens/login_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class LoginOtpScreen extends StatefulWidget {
  final String phoneNumber;
  const LoginOtpScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<LoginOtpScreen> createState() => _LoginOtpScreenState();
}

class _LoginOtpScreenState extends State<LoginOtpScreen> {
  late AuthProvider authProvider;
  final otp = TextEditingController();
  
  bool isLoading = false;
  String? errMessage;

  bool resendActive = false;
  int resendCounter = 0;
  Timer? resendTimer;

  
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    startResendTimer();
    otp.addListener(() {
      if(otp.text.length >= 6) {
        verification();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    resendTimer?.cancel();
    super.dispose();
  }

  startResendTimer() {
    final nResendTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        resendCounter--;
      });

      if(resendCounter < 1) {
        resendTimer?.cancel();
        
        setState(() {
          resendActive = true;
          resendTimer = null;
        });
      }
    });

    setState(() {
      resendActive = false;
      resendCounter = 30;
      resendTimer = nResendTimer;
    });
  }

  resendOtp() {
    authProvider.resendOtp(widget.phoneNumber).whenComplete(startResendTimer);
  }

  verification() {
    setState(() {
      isLoading = true;
      errMessage = null;
    });

    authProvider.validateOtp(widget.phoneNumber, otp.text).then((resp) {
      redirectTo(context, const HomeScreen());
    }).catchError((err) {
      setState(() {
        errMessage = 'Kode verifikasi tidak sesuai';
      });
      otp.text = '';
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
  }
  
  changePhoneNumber() {
    redirectTo(context, const LoginScreen());
  }
  
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
            Visibility(
              visible: isLoading,
              child: CircularProgressIndicator(),
            ),
            Visibility(
              visible: !isLoading,
              child: SizedBox(
                width: size(context).width * .6,
                child: InputOtp(
                  controller: otp,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: errMessage != null,
              child: Text("$errMessage", style: TextStyle(
                color: Colors.red[300],
                fontSize: 14,
              )),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: !isLoading ? resendOtp : null,
                  child: Text('Kirim ulang', style: TextStyle(
                    fontSize: 14,
                    color: resendActive ? ThemeConfig.textColor : Colors.black54
                  )),
                ),
                Visibility(
                  visible: !resendActive,
                  child: Text(" ( $resendCounter )", style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ))
                ),
              ]
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: !isLoading ? changePhoneNumber : null,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ThemeConfig.primaryColor),
                  foregroundColor: ThemeConfig.primaryColor,
                ),
                child: const Text('Ganti Nomor'),
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