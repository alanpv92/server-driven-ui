import 'package:eleverdev/helpers/app.dart';
import 'package:eleverdev/mangers/firebase.dart';

class FirebaseHelper {
  static getImagePath({required String id}) {
    return "${FirebaseManger.firebaseStorageBaseUrl}$id${AppManager.FirebaseStorageFormat}?alt=media";
  }
}
