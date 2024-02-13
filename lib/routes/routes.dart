part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/'),
        AutoRoute(
          page: LoginRoute.page,
          path: '/login',
          keepHistory: false,
        ),
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: DetailsRoute.page,
          path: '/details',
          guards: [AuthGuard()],
        ),
        AutoRoute(
          page: RegistrationRoute.page,
          path: '/registration',
          keepHistory: false,
        )
      ];
}
