// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardConfig _$CardConfigFromJson(Map<String, dynamic> json) => CardConfig(
      bgColor: json['bgColor'] as String?,
      textStyle: json['textStyle'] == null
          ? null
          : CardTextStyle.fromJson(json['textStyle'] as Map<String, dynamic>),
      text: json['text'] as String?,
      onTap: json['onTap'] == null
          ? null
          : CardOnPress.fromJson(json['onTap'] as Map<String, dynamic>),
      imageCons: json['imageCons'] == null
          ? null
          : CardImageCons.fromJson(json['imageCons'] as Map<String, dynamic>),
      imageUrl: json['imageUrl'] as String?,
      visibility: json['visibility'] as bool?,
    );

Map<String, dynamic> _$CardConfigToJson(CardConfig instance) =>
    <String, dynamic>{
      'text': instance.text,
      'bgColor': instance.bgColor,
      'textStyle': instance.textStyle?.toJson(),
      'imageCons': instance.imageCons?.toJson(),
      'onTap': instance.onTap?.toJson(),
      'visibility': instance.visibility,
      'imageUrl': instance.imageUrl,
    };

CardTextStyle _$CardTextStyleFromJson(Map<String, dynamic> json) =>
    CardTextStyle(
      color: json['color'] as String?,
      fontSize: json['fontSize'] as int?,
      fontWeight: json['fontWeight'] as int?,
    );

Map<String, dynamic> _$CardTextStyleToJson(CardTextStyle instance) =>
    <String, dynamic>{
      'color': instance.color,
      'fontSize': instance.fontSize,
      'fontWeight': instance.fontWeight,
    };

CardOnPress _$CardOnPressFromJson(Map<String, dynamic> json) => CardOnPress(
      onPress: json['onPress'] as String?,
      type: json['type'] as String?,
    );

Map<String, dynamic> _$CardOnPressToJson(CardOnPress instance) =>
    <String, dynamic>{
      'type': instance.type,
      'onPress': instance.onPress,
    };

CardImageCons _$CardImageConsFromJson(Map<String, dynamic> json) =>
    CardImageCons(
      alignment: json['alignment'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
    );

Map<String, dynamic> _$CardImageConsToJson(CardImageCons instance) =>
    <String, dynamic>{
      'height': instance.height,
      'width': instance.width,
      'alignment': instance.alignment,
    };
