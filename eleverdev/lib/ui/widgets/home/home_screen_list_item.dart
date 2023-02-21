import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/data/models/card_config.dart';
import 'package:eleverdev/helpers/alignment._helper.dart';

import 'package:eleverdev/ui/widgets/common/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenListItem extends StatelessWidget {
  final CardConfig cardConfig;
  final String id;
  const HomeScreenListItem(
      {super.key, required this.cardConfig, required this.id});

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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (cardConfig.text != null)
                    Text(
                      cardConfig.text!,
                      
                      textAlign: AlignmentHelper.getTextAlign(cardConfig.textAlign),
                      style: cardConfig.textStyle?.getCardTextStyle,
                    ),
                  Align(
                      alignment: cardConfig.imageCons == null
                          ? Alignment.center
                          : cardConfig.imageCons!.getAlignment ??
                              Alignment.center,
                      child: Consumer(
                        builder: (context, value, child) {
                          Provider.of<CacheController>(context);
                          return Visibility(
                            visible: cardConfig.imageExists ?? true,
                            child: CustomCachedImage(
                                key: UniqueKey(),
                                id: id,
                                cardImageCons: cardConfig.imageCons),
                          );
                        },
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
