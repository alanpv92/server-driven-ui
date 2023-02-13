import 'package:eleverdev/ui/screens/authentication/authentication.dart';
import 'package:eleverdev/ui/screens/home_screen/home_screen.dart';
import 'package:get/route_manager.dart';

class Routes {
  static String homeScreenRoute = '/home-screen';
  static String authentication = '/authentication-screen';
  static String unknownPage = '/error-screen';
  static String page1 = '/screen-1';
  static String page2 = '/screen-2';
}

class RouteManger {
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
