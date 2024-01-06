import 'package:easy_localization/easy_localization.dart';
import 'package:events4me/app/modules/auth/login/controller/login_controller.dart';
import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:events4me/app/shared/l10n/locale_keys.g.dart';
import 'package:events4me/app/shared/widgets/components/app_button.dart';
import 'package:events4me/app/shared/widgets/components/app_default_page.dart';
import 'package:events4me/app/shared/widgets/components/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  final LoginController loginController;

  const LoginPage({
    required this.loginController,
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var check = false;

  @override
  Widget build(BuildContext context) {
    return AppDefaultPage(
        widget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          Flexible(
            child: FractionallySizedBox(heightFactor: .1),
          ),
          Image.asset('assets/images/logo.png'),
          Form(
              child: Column(
            children: [
              AppInput(
                labelText: LocaleKeys.email.tr(),
                iconData: Icons.email,
              ),
              SizedBox(
                height: 15,
              ),
              AppInput(
                labelText: LocaleKeys.password.tr(),
                isPasswordInput: true,
              ),
            ],
          )),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () =>
                    Modular.to.pushNamed(AppModules.resetPasswordModule),
                child: Text(
                  LocaleKeys.forgotPassword.tr(),
                )),
          ),
          Flexible(
            child: FractionallySizedBox(heightFactor: .10),
          ),
          AppButton(child: Text(LocaleKeys.login.tr()), onPressed: () {}),
          Flexible(
            child: FractionallySizedBox(heightFactor: .5),
          ),
          AppButton(
              buttonColor: AppColors.grey1,
              child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/images/google.png')),
              onPressed: () {}),
          Flexible(
            child: FractionallySizedBox(heightFactor: .20),
          ),
          AppButton(
              child: Text(LocaleKeys.registration.tr()), onPressed: () {}),
        ]));
  }
}
