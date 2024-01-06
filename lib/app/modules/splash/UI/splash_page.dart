import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  // void initState() {
  //   if (true) {
  //     FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //       if (user != null) {
  //         Modular.to.navigate(AppModules.eventModule);
  //       } else {
  //         Modular.to.navigate(AppModules.loginModule);
  //       }
  //     });
  //   }
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SplashPage'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Modular.to.navigate(AppModules.loginModule),
            child: Text('Clique'),
          ),
        ));
  }
}
