import 'package:eleverdev/ui/screens/authentication/authentication.dart';
import 'package:eleverdev/ui/screens/error/error_screen.dart';
import 'package:eleverdev/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Routes {
  static String homeScreenRoute = '/home-screen';
  static String authentication = '/authentication-screen';
  static String unknownPage = '/error-screen';
  static String page1 = '/screen-1';
  static String page2 = '/screen-2';
}

class RouteManger {
  static MaterialPageRoute getUnknownRoute(settings) =>
      MaterialPageRoute(builder: (context) => const ErrorScreen());
  static getRoutes() => [
        GetPage(
          name: Routes.authentication,
          page: () => const AuthenticationScreen(),
        ),
        GetPage(
          name: Routes.homeScreenRoute,
          page: () => const HomeScreen(),
        ),
      ];
}
