import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleverdev/controllers/base.dart';

import 'package:eleverdev/data/models/card_model.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/firebase/firebase_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomePageController extends BaseController {
  //creates an private contructor of HomePageController
  HomePageController._();
  //creates an static instance of HomePageController
  static HomePageController instance = HomePageController._();
  //returns the static instance when contructor of HomePageController is  called
  factory HomePageController() => instance;
  //creates an instance of FirebaseFireStoreService
  final FirebaseFireStoreService _firebaseFireStoreService =
      FirebaseFireStoreService();

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapShot() {
    // function returns an stream for collection cardConfigCollection
    final snap = _firebaseFireStoreService.getCollectionQuerySnapShot(
        collectionName: FirebaseManger.cardConfigCollection);
    return snap;
  }

  final List<CardModel> cards = [];

  void populateListView(List<DocumentSnapshot> data) {
    //function to populate card data according to firebase configrations
    cards.clear();
    for (var element in data) {
      final elementData = element.data() as Map<String, dynamic>;
      final cardModel = CardModel(elementData: elementData, id: element.id);
      cards.add(cardModel);
      cards.sort((a, b) => a.position.compareTo(b.position));
    }
  }

  showGetSnackBar() {
    // This function shows an snackbar when called
    Get.snackbar('u clicked card', '',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.black);
  }

  homePageControllerDisposer() {
    cards.clear();
    isloading = false;
  }
}
