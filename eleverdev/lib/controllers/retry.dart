import 'dart:developer';

import 'package:eleverdev/controllers/authentication.dart';
import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/main.dart';
import 'package:eleverdev/mangers/routes.dart';
import 'package:eleverdev/ui/screens/authentication/authentication.dart';
import 'package:eleverdev/ui/screens/splash/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class RetryController extends BaseController {
  RetryController._();
  static RetryController instance = RetryController._();
  factory RetryController() => instance;

  retry({required String routeName}) async {
    if (routeName.isEmpty || routeName == '/') {
      if (FirebaseAuth.instance.currentUser != null) {
        Get.offAll(() => const SplashScreen());
      } else {
        Get.offAll(() => const AuthenticationScreen());
      }
    } else {
      log(routeName.toString());
      Get.offAndToNamed(routeName);
    }
  }
}
