import 'package:events4me/app/modules/splash/splash_page.dart';
import 'package:events4me/app/shared/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme().themeData,
      home: const SplashPage(),
    );
  }
}
