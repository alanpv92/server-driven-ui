import 'dart:developer';

import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/helpers/font_weight.dart';
import 'package:flutter/material.dart';

class CardModel {
  final int position;
  final Widget widget;

  CardModel._({required this.position, required this.widget});

  factory CardModel(
      {required Map<String, dynamic> elementData}) {
   
    final String? text = elementData['text'];
    final Color? bgColor = HexColor.fromHex(elementData['bgColor']);
    final Color? textColor =
        HexColor.fromHex(elementData['textStyle']['color']);
    final double? fontSize =
        double.tryParse(elementData['textStyle']['fontSize'].toString());
    final FontWeight? fontWeight = FontWeightHelper.getFontWeight(
        int.tryParse(elementData['textStyle']['fontWeight'].toString()));
    final bool visibility = elementData['visibility'];
    final String? imageUrl = elementData['imageUrl'];
    final double? imageCons =
        double.tryParse(elementData['imageCons'].toString());
    final Widget widget = Visibility(
        visible: visibility,
        child: Card(
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              borderSide: BorderSide.none),
          color: bgColor,
          child: Column(
            children: [
              ListTile(
                title: text != null
                    ? Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontWeight: fontWeight,
                        ),
                      )
                    : null,
              ),
              imageUrl != null
                  ? Container(
                      width: double.infinity,
                      height: 200,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(top: imageCons ?? 0.0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ))
                  : const SizedBox(),
            ],
          ),
        ));

    return CardModel._(position: elementData['pos']??-1, widget: widget);
  }
}
