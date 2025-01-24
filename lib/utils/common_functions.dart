import 'package:flutter/material.dart';
import 'package:wartel_receiver/configs/app_config.dart';

Size size(BuildContext context) => MediaQuery.sizeOf(context);

void redirectTo(BuildContext context, Widget screen) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => screen,
    ),
    (route) => false,
  );
}

void showSnackBar(String message, {
  Function? onClosed, 
  double? width
}) {
  final SnackBar snackBar = SnackBar(
    width: width,
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
    shape: const StadiumBorder(),
    behavior: SnackBarBehavior.floating,
  );
  AppConfig.scaffoldMessengerKey.currentState
      ?.showSnackBar(snackBar)
      .closed
      .then((value) {
    if (onClosed != null) {
      onClosed();
    }
  });
}
