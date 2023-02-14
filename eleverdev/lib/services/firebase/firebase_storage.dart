
// ignore: depend_on_referenced_packages
import 'package:eleverdev/data/models/firebase_response.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<FirebaseResponse> getImageById({required String id}) async {
    try {
      final ref = _firebaseStorage.ref().child('$id.jpg');
      var imageUrl = await ref.getDownloadURL();
      return FirebaseResponse(status: true, data: imageUrl);
    } catch (e) {
      return FirebaseResponse(status: false);
    }
  }
}
