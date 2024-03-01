import 'package:asuka/asuka.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:events4me/app/modules/auth/login/controller/login_controller.dart';
import 'package:events4me/app/modules/auth/login/states/login_state.dart';
import 'package:events4me/app/shared/constants/app_colors.dart';
import 'package:events4me/app/shared/constants/app_modules.dart';
import 'package:events4me/app/shared/l10n/locale_keys.g.dart';
import 'package:events4me/app/shared/utils/tools.dart';
import 'package:events4me/app/shared/widgets/components/app_button.dart';
import 'package:events4me/app/shared/widgets/components/app_default_page.dart';
import 'package:events4me/app/shared/widgets/components/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatelessWidget {
  /// Login controller instance
  final LoginController controller;

  /// Class constructor
  LoginPage({
    super.key,
    required this.controller,
  });

  /// Tools instance
  final tools = Modular.get<Tools>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginController, LoginState>(
      bloc: controller,
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          return AsukaSnackbar.alert(state.error ?? '').show();
        }
      },
      child: Scaffold(
          body: BlocSelector<LoginController, LoginState, bool>(
        bloc: controller,
        selector: (state) {
          return state.status == LoginStatus.loading;
        },
        builder: (context, showLoading) {
          return AppDefaultPage(
            showLoading: showLoading,
            child: SingleChildScrollView(
              child: SizedBox(
                height: Tools.size.height + 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    //* Header
                    Flexible(
                      child: FractionallySizedBox(heightFactor: .1),
                    ),
                    Image.asset('assets/images/logo.png'),

                    //* Login Form
                    Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            AppInput(
                              labelText: LocaleKeys.email.tr(),
                              iconData: Icons.email,
                              textInputAction: TextInputAction.next,
                              onFieldSubimited: (_) => FocusScope.of(context).nextFocus(),
                              validator: tools.emailValidator(),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            AppInput(
                              labelText: LocaleKeys.password.tr(),
                              isPasswordInput: true,
                              validator: tools.passwordValidator(),
                            ),
                          ],
                        )),

                    //* Action Buttons
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Modular.to.pushNamed(AppModules.resetPasswordModule),
                        child: Text(LocaleKeys.forgotPassword.tr()),
                      ),
                    ),
                    Flexible(
                      child: FractionallySizedBox(heightFactor: .10),
                    ),
                    AppButton(
                      child: Text(
                        LocaleKeys.login.tr(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onPressed: () async {
                        if (controller.formKey.currentState?.validate() ?? false) {
                          await controller.login(email: '', password: '');
                          if (controller.state.status == LoginStatus.success) {
                            Modular.to.navigate(AppModules.eventModule);
                          }
                        }
                      },
                    ),
                    Flexible(
                      child: FractionallySizedBox(heightFactor: 20),
                    ),
                    AppButton(
                      buttonColor: AppColors.grey1,
                      child: SizedBox(width: 20, height: 20, child: Image.asset('assets/images/google.png')),
                      onPressed: () => controller.loginWithGoogle(),
                    ),
                    Flexible(
                      child: FractionallySizedBox(heightFactor: .5),
                    ),
                    AppButton(
                        child: Text(
                          LocaleKeys.registration.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        onPressed: () => Modular.to.pushNamed(AppModules.registerModule)),
                  ]),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
