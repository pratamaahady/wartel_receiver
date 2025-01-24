import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wartel_receiver/configs/theme_config.dart';

class AppLayout extends StatelessWidget {
  final bool isLoading;
  final Function? onPop;
  final Color? backgroundColor;
  final Widget? bottomSheet;
  final Widget child;

  const AppLayout({
    super.key,
    this.isLoading=false,
    this.onPop,
    this.backgroundColor,
    this.bottomSheet,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: ThemeConfig.textColor,
      statusBarColor: Colors.transparent,
    ));

    return PopScope(
      canPop: false,
      onPopInvoked: (result) {
        if(onPop != null) {
          onPop!();
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor ?? ThemeConfig.backgroundColor,
        body: Stack(
          children: [
            child,
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black.withOpacity(.1),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: ThemeConfig.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomSheet: bottomSheet,
      ),
    );
  }
}