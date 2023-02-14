import 'package:eleverdev/controllers/home_page.dart';
import 'package:get/route_manager.dart';

class OnPressHelper {
  static getOnPressAction({required String? onPress,required String? type}) {
    if (onPress == null || type== null) {
      return;
    }
    switch (type) {
      case 'route':
        Get.toNamed(onPress);
        return;
      case 'function':
        onPressFunction(onPress);
        return;
      default:
        return;
    }
  }

  static onPressFunction(String functionName) {
    /*

     This function is used call different functions based on function name

    */
    switch (functionName) {
      case "showSnackBar":
        HomePageController().showGetSnackBar();
        return;
      default:
        return;
    }
  }
}
