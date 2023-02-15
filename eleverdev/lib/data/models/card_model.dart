import 'package:eleverdev/data/models/card_config.dart';

class CardModel {
  final String id;
  final int position;
  final CardConfig cardConfig;

  CardModel._({required this.position, required this.cardConfig,required this.id});
  factory CardModel({required Map<String, dynamic> elementData,required String id}) {
    return CardModel._(
         id: id,
        position: elementData['pos'] ?? -1,
        cardConfig: CardConfig.fromJson(elementData));
  }
}
