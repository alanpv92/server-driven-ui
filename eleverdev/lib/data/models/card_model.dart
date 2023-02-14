

import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/data/models/card_config.dart';
import 'package:get/route_manager.dart';

class CardModel {
  final int position;
  final CardConfig cardConfig;

  CardModel._({required this.position, required this.cardConfig});
  factory CardModel({required Map<String, dynamic> elementData}) {
    return CardModel._(
        position: elementData['pos'] ?? -1,
        cardConfig: CardConfig.fromJson(elementData));
  }
}
