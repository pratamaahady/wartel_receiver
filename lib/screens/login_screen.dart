import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/components/app_layout.dart';
import 'package:wartel_receiver/components/app_logo.dart';
import 'package:wartel_receiver/configs/theme_config.dart';
import 'package:wartel_receiver/providers/auth_provider.dart';
import 'package:wartel_receiver/screens/login_otp_screen.dart';
import 'package:wartel_receiver/utils/common_functions.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ super.key });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider authProvider;
  final name = TextEditingController();
  final nameFocus = FocusNode();
  final phoneNumber = TextEditingController();
  final phoneNumberFocus = FocusNode();

  bool isLoading = false;
  String? errMessage;
  
  @override
  void initState() {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  login() {
    setState(() {
      isLoading = true;
      errMessage = null;
    });
    
    authProvider.login(name.text, phoneNumber.text).then((resp) {
      redirectTo(context, LoginOtpScreen(
        phoneNumber: phoneNumber.text
      ));
    }).catchError((err) {
      setState(() {
        errMessage = 'Nomor Whatsapp tidak terdafatar.';
      });

      phoneNumber.text = '';
      phoneNumberFocus.requestFocus();
    }).whenComplete(() {
      setState(() {
        isLoading = false;
      });
    });
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
              controller: name,
              focusNode: nameFocus,
              decoration: const InputDecoration(
                hintText: 'Nama Lengkap'
              ),
              enabled: !isLoading,
              onFieldSubmitted: (val) => phoneNumberFocus.requestFocus(),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: phoneNumber,
              focusNode: phoneNumberFocus,
              keyboardType: const TextInputType.numberWithOptions(),
              decoration: const InputDecoration(
                hintText: 'Nomor Telepon',
              ),
              enabled: !isLoading,
              onFieldSubmitted: (value) => login(),
            ),
            const SizedBox(height: 10),
            Visibility(
              visible: errMessage != null,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                child: Text(errMessage ?? '', style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 14,
                )),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: !isLoading ? login : null,
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