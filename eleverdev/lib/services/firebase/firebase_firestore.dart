import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleverdev/mangers/firebase.dart';

/*
This class will contain all firestore methods required for this application
*/

class FirebaseFireStoreService {
  final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance; //creating an instance of firestore

/*
 This function returns a snapshot to a specified collection,which can be used to listen for real time changes
*/

  Stream<QuerySnapshot<Map<String, dynamic>>> getCollectionQuerySnapShot(
      {required String collectionName}) {
    final Stream<QuerySnapshot<Map<String, dynamic>>> querySnapshot =
        _firebaseFirestore.collection(collectionName).snapshots();
    return querySnapshot;
  }

  Future configureData() async {
    /*

    This function is used to prove intial data

    */
    final cardConfig =
        _firebaseFirestore.collection(FirebaseManger.cardConfigCollection);
    final card1 = <String, dynamic>{
      "pos":0,
      "text": "alan",
      "textStyle": {"color": "#ED9728", "fontSize": 10, "fontWeight": 100},
      "imageUrl": "https://source.unsplash.com/random",
      "imageCons": 20,
      "bgColor": "#070200",
      "visibility": true
    };

    final card2 = <String, dynamic>{
      "pos":1,
      "text": "alan1",
      "textStyle": {"color": "#e61f34", "fontSize": 20, "fontWeight": 100},
      "imageUrl": "https://source.unsplash.com/random",
      "imageCons": 20,
      "bgColor": "#FFFFFF",
      "visibility": true
    };

    final card3 = <String, dynamic>{
      "pos":2,
      "text": "alan",
      "textStyle": {"color": "#FFFFFF", "fontSize": 10, "fontWeight": 100},
      "imageUrl": "https://source.unsplash.com/random",
      "imageCons": 20,
      "bgColor": "#ED9728",
      "visibility": true
    };
    cardConfig.add(card1);
    cardConfig.add(card2);
    cardConfig.add(card3);
  }
}
