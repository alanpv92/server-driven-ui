import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/firebase/firebase_firestore.dart';
import 'package:flutter/material.dart';
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

  final List<Widget> cards = [];

  FontWeight? getFontWeight(int? frontNumber) {
    switch (frontNumber) {
      case null:
        return null;
      case 100:
        return FontWeight.w100;
      case 200:
        return FontWeight.w200;
      case 300:
        return FontWeight.w300;
      case 400:
        return FontWeight.w400;
      case 500:
        return FontWeight.w500;
      case 600:
        return FontWeight.w600;
      case 700:
        return FontWeight.w700;
      case 800:
        return FontWeight.w800;
      case 900:
        return FontWeight.w900;
      default:
        return FontWeight.normal;
    }
  }

  void populateListView(List<DocumentSnapshot> data) {
    cards.clear();
    log(cards.length.toString());
    for (var element in data) {
      final elementData = element.data() as Map<String, dynamic>;
      final String? text = elementData['text'];
      final Color? bgColor = HexColor.fromHex(elementData['bgColor']);
      final Color? textColor = HexColor.fromHex(element['textStyle']['color']);
      final double? fontSize =
          double.tryParse(elementData['textStyle']['fontSize']);
      final FontWeight? fontWeight =
          getFontWeight(int.tryParse(elementData['textStyle']['fontWeight']));
      final bool visibility = elementData['visibility'];
      cards.add(Visibility(
          visible: visibility,
          child: ListTile(
            title: text != null
                ? Text(
                    text,
                    style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: fontWeight,
                        backgroundColor: bgColor),
                  )
                : null,
          )));
    }
  }
}
