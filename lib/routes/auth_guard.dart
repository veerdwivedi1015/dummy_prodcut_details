import 'package:auto_route/auto_route.dart';
import 'package:demo_assignment/routes/routes_import.gr.dart';
import 'package:demo_assignment/services/shared_prefrence/shared_prefrence_config.dart';
import 'package:demo_assignment/utils/functions.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var instance = await SharedPrefSingleton().getInstance();
    var value = instance.get('userLogin');
    if (value == null) {
      router.removeLast();
    } else {
      var date = Functions.formatIsoDate(value as String);
      if (DateTime.now().isAfter(date)) {
        router.removeLast();
        router.push(LoginRoute(isSessionOut: true));
      } else {
        resolver.next(true);
      }
    }
  }
}
