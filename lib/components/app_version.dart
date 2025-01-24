import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wartel_receiver/providers/app_provider.dart';

class AppVersion extends StatelessWidget {
  const AppVersion({ super.key });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, value, child) => Text(
        "v${value.version}",
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 12,
        )
      )
    );
  }
}