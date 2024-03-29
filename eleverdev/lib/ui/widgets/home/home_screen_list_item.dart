

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
      child: InkWell(
        onTap: () {
          cardConfig.onTap?.action();
        },
        child: Card(
            color: HexColor.fromHex(cardConfig.bgColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (cardConfig.text != null)
                    Text(
                      cardConfig.text!,
                      style: cardConfig.textStyle?.getCardTextStyle,
                    ),
                  if (cardConfig.imageUrl != null)
                    Align(
                      alignment: cardConfig.imageCons == null
                          ? Alignment.center
                          : cardConfig.imageCons!.getAlignment ??
                              Alignment.center,
                      child: CachedNetworkImage(
                        fit: BoxFit.scaleDown,
                        imageUrl: cardConfig.imageUrl!,
                        height: cardConfig.imageCons?.getHeight,
                        width: cardConfig.imageCons?.getWidth,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}
