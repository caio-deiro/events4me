import 'package:asuka/asuka.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:events4me/app/shared/constants/theme/app_theme.dart';
import 'package:events4me/app/shared/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Tools().getSizeOfScreen(context);
    return MaterialApp.router(
      builder: Asuka.builder,
      theme: AppTheme.themeData,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: Modular.routerConfig,
    );
  }
}
