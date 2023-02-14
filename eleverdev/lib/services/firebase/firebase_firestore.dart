import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:flutter/material.dart';

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

    //https://source.unsplash.com/random
    final cardConfig =
        _firebaseFirestore.collection(FirebaseManger.cardConfigCollection);
    final card1 = <String, dynamic>{
      "pos": 0,
      "text": "alan",
      "textStyle": {"color": "#ED9728", "fontSize": 10, "fontWeight": 100},
      "bgColor": "#070200",
      "imageCons": {
        "height": 50,
        "width": 50,
        "alignment": Alignment.center.toString(),
      },
      "visibility": true,
      "onTap": {
        "type": "route",
        "onPress": '/screen-1',
      }
    };

    final card2 = <String, dynamic>{
      "pos": 1,
      "text": "alan1",
      "textStyle": {"color": "#e61f34", "fontSize": 20, "fontWeight": 100},
      "imageCons": {
        "height": 50,
        "width": 50,
        "alignment": Alignment.center.toString(),
      },
      "bgColor": "#FFFFFF",
      "visibility": true,
      "onTap": {
        "type": "function",
        "onPress": "removeCard",
      }
    };

    final card3 = <String, dynamic>{
      "pos": 2,
      "text": "alan",
      "textStyle": {"color": "#FFFFFF", "fontSize": 10, "fontWeight": 100},
      "imageCons": {
        "height": 50,
        "width": 50,
        "alignment": Alignment.center.toString(),
      },
      "bgColor": "#ED9728",
      "visibility": true,
      "onTap": {
        "type": "null",
        "onPress": "",
      }
    };
    cardConfig.add(card1);
    cardConfig.add(card2);
    cardConfig.add(card3);
  }
}
