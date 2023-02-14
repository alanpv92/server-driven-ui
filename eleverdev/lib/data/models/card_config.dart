

import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/helpers/alignment._helper.dart';
import 'package:eleverdev/helpers/font_weight.dart';
import 'package:eleverdev/helpers/onpress_helper.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'card_config.g.dart';

@JsonSerializable(explicitToJson: true)
class CardConfig {
  final String? text;
  final String? bgColor;
  final CardTextStyle? textStyle;
  final CardImageCons imageCons;
  final CardOnPress? onTap;
  final bool? visibility;
  CardConfig(
      {required this.bgColor,
      required this.textStyle,
      required this.text,
      required this.onTap,
      required this.imageCons,
      required this.visibility});
  factory CardConfig.fromJson(Map<String, dynamic> json) =>
      _$CardConfigFromJson(json);
}

@JsonSerializable()
class CardTextStyle {
  final String? color;
  final int? fontSize;
  final int? fontWeight;
  CardTextStyle(
      {required this.color, required this.fontSize, required this.fontWeight});
  factory CardTextStyle.fromJson(Map<String, dynamic> json) =>
      _$CardTextStyleFromJson(json);
  Map<String, dynamic> toJson() => _$CardTextStyleToJson(this);

  TextStyle? get getCardTextStyle => TextStyle(
      color: HexColor.fromHex(color),
      fontSize: fontSize != null ? double.tryParse(fontSize.toString()) : null,
      fontWeight: FontWeightHelper.getFontWeight(fontSize));
}

@JsonSerializable()
class CardOnPress {
  final String? type;
  final String? onPress;
  CardOnPress({required this.onPress, required this.type});
  factory CardOnPress.fromJson(Map<String, dynamic> json) =>
      _$CardOnPressFromJson(json);
  Map<String, dynamic> toJson() => _$CardOnPressToJson(this);
  void action() {
   
    OnPressHelper.getOnPressAction(onPress: onPress, type: type);
  }
}

@JsonSerializable()
class CardImageCons {
  final int? height;
  final int? width;
  final String? alignment;
  CardImageCons(
      {required this.alignment, required this.height, required this.width});
  factory CardImageCons.fromJson(Map<String, dynamic> json) =>
      _$CardImageConsFromJson(json);
  Map<String, dynamic> toJson() => _$CardImageConsToJson(this);

  double? get getHeight =>
      height == null ? null : double.parse(height.toString());
  double? get getWidth => width == null ? null : double.parse(width.toString());

  Alignment? get getAlignment =>
      AlignmentHelper.getAlignMent(alignment: alignment);
}
