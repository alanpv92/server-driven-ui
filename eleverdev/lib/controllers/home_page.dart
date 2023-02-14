import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleverdev/controllers/base.dart';

import 'package:eleverdev/data/models/card_model.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/firebase/firebase_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

/*
This class contains all the functions required for home page of this application
*/

class HomePageController extends BaseController {
  final FirebaseFireStoreService _firebaseFireStoreService =
      FirebaseFireStoreService(); //creates an instance of firebse service

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapShot() {
    final snap = _firebaseFireStoreService.getCollectionQuerySnapShot(
        collectionName: FirebaseManger.cardConfigCollection);
    return snap;
  } // function returns an stream for collection cardConfigCollection

  final List<CardModel> cards = []; 


  void populateListView(List<DocumentSnapshot> data) {
    /* 

    function to populate card data according to firebase configrations

    */
    cards.clear();
    for (var element in data) {
      final elementData = element.data() as Map<String, dynamic>;
      final cardModel = CardModel(elementData: elementData);
      cards.add(cardModel);
      cards.sort((a, b) => a.position.compareTo(b.position));
    }
  }

  showGetSnackBar() {
    /*
     This function shows an snackbar when called

    */
    Get.snackbar('u clicked card', '',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black);
  }
}
