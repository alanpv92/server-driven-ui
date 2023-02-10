import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFireStoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionQuerySnapShot(
      {required String collectionName}) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        _firebaseFirestore.collection(collectionName).snapshots();
    return querySnapshot;
  }
}
