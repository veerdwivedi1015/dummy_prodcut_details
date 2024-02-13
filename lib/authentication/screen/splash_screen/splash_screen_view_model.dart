import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/routes/routes_import.gr.dart';
import 'package:demo_assignment/services/shared_prefrence/shared_prefrence_config.dart';
import 'package:demo_assignment/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashScreenViewModel extends BaseViewModel {
  bool gotoLogin = true;

  void init(AnimationController controller, BuildContext context) async {
    controller.forward().whenComplete(() => handelNavigation(context));
    SharedPrefSingleton().initialize().whenComplete(() async {
      var instance = await SharedPrefSingleton().getInstance();
      var result = instance.get('userLogin');
      if (result != null) {
        var time = Functions.formatIsoDate(result as String);
        if (DateTime.now().isBefore(time)) {
          gotoLogin = false;
        }
      }
    });
  }

  void handelNavigation(BuildContext context) {
    if (gotoLogin) {
      AutoRouter.of(context).push(LoginRoute());
    } else {
      AutoRouter.of(context).push(const HomeRoute());
    }
  }
}
