import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/data/models/card_config.dart';
import 'package:flutter/material.dart';

class HomeScreenListItem extends StatelessWidget {
  final CardConfig cardConfig;
  const HomeScreenListItem({super.key, required this.cardConfig});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cardConfig.visibility ?? false,
      child: Card(
          color: HexColor.fromHex(cardConfig.bgColor),
          child: Column(
            children: [
              if (cardConfig.text != null)
                Text(
                  cardConfig.text!,
                  style: cardConfig.textStyle?.getCardTextStyle,
                ),
                
            ],
          )),
    );
  }
}
