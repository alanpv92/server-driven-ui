import 'package:cloud_firestore/cloud_firestore.dart';

/*
This class will contain all firestore methods required for this application
*/

class FirebaseFireStoreService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;//creating an instance of firestore


/*
 This function returns a snapshot to a specified collection,which can be used to listen for real time changes
*/

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionQuerySnapShot(
      {required String collectionName}) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        _firebaseFirestore.collection(collectionName).snapshots();
    return querySnapshot;
  }
}
