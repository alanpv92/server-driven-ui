import 'package:cached_network_image/cached_network_image.dart';
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
              SizedBox(
                width: double.infinity,
                child: CachedNetworkImage(
                  fit: BoxFit.scaleDown,
                  imageUrl: 'https://source.unsplash.com/random',
                  height: 50,
                  width: 50,
                  alignment: Alignment.topCenter,
                ),
              )
            ],
          )),
    );
  }
}
