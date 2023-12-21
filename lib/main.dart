import 'package:events4me/app/app_module.dart';
import 'package:events4me/app/app_widget.dart';
import 'package:events4me/app/shared/l10n/l10n_service.dart';
import 'package:events4me/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(EasyLocalization(
      supportedLocales: L10nService.locales,
      path: 'assets/l10n',
      fallbackLocale: L10nService.locales[1],
      child: ModularApp(module: AppModule(), child: const AppWidget())));
}
