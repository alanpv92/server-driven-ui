import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/controllers/home_page.dart';


class AppController extends BaseController {
  //creates an private constructor of AppController
  AppController._();
  //creates an static instance of AppController
  static AppController instance = AppController._();
  //returns the static instance of AppController
  factory AppController() => instance;
  initApp() async {
    //functions performs various initializations for the working off app
    //function the set the image directory path
    await CacheController.instance.setImageBasePath();
  }

  disposeApp() async {
    //function performs cleaning up of data when app is disposed
    CacheController.instance.cacheControllerDisposer();
    HomePageController.instance.homePageControllerDisposer();
  }
}
