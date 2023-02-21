import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/ui/screens/authentication/authentication.dart';
import 'package:eleverdev/ui/screens/splash/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class RetryController extends BaseController {
  //creates an Private Contructor of RetryController
  RetryController._();
  //creates an static intance of RetryController
  static RetryController instance = RetryController._();
  //returns an static instance when contructor of Retry Controller is called
  factory RetryController() => instance;

  retry({required String routeName}) async {
    //if route name is empty then it will redirect to splashScreen or AuthScreen base if FirebaseAuth.intance.currentUser
    if (routeName.isEmpty || routeName == '/') {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const SplashScreen());
      } else {
        Get.offAll(() => const AuthenticationScreen());
      }
    } else {
      //else it will go to Route name
      Get.offAndToNamed(routeName);
    }
  }
}
