import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/authentication/screen/login_screen/login_screen_viewmodel.dart';
import 'package:demo_assignment/components/atom/typography1.dart';
import 'package:demo_assignment/components/atom/typography2.dart';
import 'package:demo_assignment/components/molecule/button.dart';
import 'package:demo_assignment/components/molecule/text_input.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, this.isSessionOut = false});

  final bool isSessionOut;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => LoginScreenViewModel(),
        onViewModelReady: (model) => model.init(context, isSessionOut),
        builder: (ctx, model, _) => _Body(model: model));
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.model});

  final LoginScreenViewModel model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Typography1(data: 'Login'),
      ),
      body: SizedBox(
        width: Functions.responsiveDeviceWidth(
          context: context,
          percent: 100,
        ),
        height: Functions.responsiveHeight(
          context: context,
          percent: 100,
        ),
        child: InkWell(
          splashColor: Colors.transparent,
          onTap: () => model.dismissKeyboard(),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Typography1(
                  data: 'Nice to see you again!!',
                  textColor: Colors.black,
                  underLine: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                Form(
                  key: model.formKey,
                  child: Column(
                    children: [
                      TextInput(
                        node: model.emailNode,
                        controller: model.emailController,
                        lableText: 'Email',
                        inputType: TextInputType.emailAddress,
                        icon: Icons.email,
                        callback: (value) => model.validateEmail(value),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextInput(
                        node: model.passwordNode,
                        controller: model.passwordController,
                        lableText: 'Password',
                        inputType: TextInputType.text,
                        isObscure: model.isObscure,
                        icon: model.getIcons(),
                        onSuffixIconClicked: () => model.onSuffixIconsClicked(),
                        callback: (value) => model.validatePassword(value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                CommonButton(
                  buttonTitle: 'Login',
                  isBusy: model.isBusy,
                  callback: () => model.onLoginClicked(context),
                  textColor: Colors.white,
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                    onTap: () => model.handelSignIn(context),
                    child: SizedBox(
                      width: Functions.responsiveDeviceWidth(
                        context: context,
                        percent: 100,
                      ),
                      child: const TypoGraphy2(
                        data: 'Sign In',
                        textColor: Colors.black,
                        align: TextAlign.right,
                        underLine: true,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
