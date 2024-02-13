import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/routes/routes_import.gr.dart';
import 'package:demo_assignment/services/shared_prefrence/shared_prefrence_config.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginScreenViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String emailErrorMessage = "";
  String passwordErrorMessage = "";

  bool _isObscure = true;
  bool get isObscure => _isObscure;

  init(BuildContext context, bool isSessionOut) {
    if (isSessionOut) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Functions.showSnackbar(context, 'Please login again session out');
      });
    }
  }

  void dismissKeyboard() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    } else if (passwordNode.hasFocus) {
      passwordNode.unfocus();
    }
  }

  IconData getIcons() {
    if (isObscure) {
      return Icons.visibility_off;
    }
    return Icons.visibility;
  }

  void onSuffixIconsClicked() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  void onLoginClicked(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      var check = await checkValidUser();

      if (check) {
        var instance = await SharedPrefSingleton().getInstance();
        await instance.setString('userLogin',
            DateTime.now().add(const Duration(seconds: 100)).toIso8601String());
        if (context.mounted) {
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
        }
      } else {
        if (context.mounted) {
          Functions.showSnackbar(context, 'Please enter valid credentials');
        }
      }
    } else {
      notifyListeners();
    }
    setBusy(false);
  }

  Future<bool> checkValidUser() async {
    var instance = await SharedPrefSingleton().getInstance();
    var value = instance.get(emailController.text) as String?;
    if (value == passwordController.text) {
      return true;
    }
    return false;
  }

  String? validateEmail(String value) {
    if (value.trim() == '') {
      emailErrorMessage = 'Please provide a valid email';
      return emailErrorMessage;
    } else {
      emailErrorMessage = "";
      return null;
    }
  }

  validatePassword(value) {
    if (value.trim() == '') {
      passwordErrorMessage = 'Please provide a valid password';
      return passwordErrorMessage;
    } else {
      passwordErrorMessage = "";
      return null;
    }
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handelSignIn(BuildContext context) {
    AutoRouter.of(context).push(const RegistrationRoute());
  }
}
