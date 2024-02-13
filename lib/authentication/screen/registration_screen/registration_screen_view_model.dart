import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/routes/routes_import.gr.dart';
import 'package:demo_assignment/services/shared_prefrence/shared_prefrence_config.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegistrationScreenViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String emailErrorMessage = "";
  String passwordErrorMessage = "";
  String confirmPasswordErrorMessage = "";

  bool _isObscurePassword = true;
  bool get isObscurePassword => _isObscurePassword;

  bool _isObscuredConfirmPassword = true;
  bool get isObscuredConfirmPassword => _isObscuredConfirmPassword;

  void dismissKeyboard() {
    if (emailNode.hasFocus) {
      emailNode.unfocus();
    } else if (passwordNode.hasFocus) {
      passwordNode.unfocus();
    } else if (confirmPasswordNode.hasFocus) {
      confirmPasswordNode.unfocus();
    }
  }

  IconData getIcons(bool value) {
    if (value) {
      return Icons.visibility_off;
    }
    return Icons.visibility;
  }

  void onSuffixIconsClicked() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void onSuffixIconsConfirmClicked() {
    _isObscuredConfirmPassword = !_isObscuredConfirmPassword;
    notifyListeners();
  }

  void onSignupClicked(BuildContext context) async {
    setBusy(true);
    if (formKey.currentState!.validate()) {
      var check = await checkUserExist();

      if (!check) {
        var instance = await SharedPrefSingleton().getInstance();
        await instance.setString('userLogin',
            DateTime.now().add(const Duration(seconds: 100)).toIso8601String());
        await instance.setString(emailController.text, passwordController.text);
        if (context.mounted) {
          AutoRouter.of(context).replaceAll([const HomeRoute()]);
        }
      } else {
        if (context.mounted) {
          Functions.showSnackbar(context, 'User already exist');
        }
      }
    } else {
      notifyListeners();
    }
    setBusy(false);
  }

  Future<bool> checkUserExist() async {
    var instance = await SharedPrefSingleton().getInstance();
    var value = instance.get(emailController.text) as String?;
    if (value == null) {
      return false;
    }
    return true;
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

  validateConfirmPassword(value) {
    if (value.trim() == '') {
      confirmPasswordErrorMessage = 'Please provide a valid password';
      return confirmPasswordErrorMessage;
    } else if (value != passwordController.text) {
      confirmPasswordErrorMessage = 'Password matching failed';
      return confirmPasswordErrorMessage;
    } else {
      confirmPasswordErrorMessage = "";
      return null;
    }
  }

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  handleLogin(BuildContext context) {
    AutoRouter.of(context).push(LoginRoute());
  }
}
