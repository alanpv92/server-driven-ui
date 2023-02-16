import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/controllers/home_page.dart';

class AppController extends BaseController {
  AppController._();
  static AppController instance = AppController._();
  factory AppController() => instance;
  initApp() async {
    await CacheController.instance.loadImages();
  }

  disposeApp() {
    CacheController.instance.cacheControllerDisposer();
    HomePageController.instance.homePageControllerDisposer();
  }
}
