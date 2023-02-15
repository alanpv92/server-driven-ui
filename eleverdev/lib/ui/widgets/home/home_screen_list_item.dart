import 'dart:developer';

import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/data/extentions/extentions.dart';
import 'package:eleverdev/data/models/card_config.dart';

import 'package:eleverdev/ui/widgets/common/custom_cached_image.dart';
import 'package:flutter/material.dart';

class HomeScreenListItem extends StatefulWidget {
  final CardConfig cardConfig;
  final String id;
  const HomeScreenListItem(
      {super.key, required this.cardConfig, required this.id});

  @override
  State<HomeScreenListItem> createState() => _HomeScreenListItemState();
}

class _HomeScreenListItemState extends State<HomeScreenListItem> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CacheController.instance.loadImages();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.cardConfig.visibility ?? false,
      child: InkWell(
        onTap: () {
          widget.cardConfig.onTap?.action();
        },
        child: Card(
            color: HexColor.fromHex(widget.cardConfig.bgColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (widget.cardConfig.text != null)
                    Text(
                      widget.cardConfig.text!,
                      style: widget.cardConfig.textStyle?.getCardTextStyle,
                    ),
                  Align(
                    alignment: widget.cardConfig.imageCons == null
                        ? Alignment.center
                        : widget.cardConfig.imageCons!.getAlignment ??
                            Alignment.center,
                    child: CustomCachedImage(id: widget.id),
                    // child: CachedNetworkImage(
                    //   fit: BoxFit.scaleDown,
                    //   imageUrl: FirebaseHelper.getImagePath(id: id),
                    //   height: cardConfig.imageCons?.getHeight,
                    //   width: cardConfig.imageCons?.getWidth,
                    //   placeholder: (context, url) =>
                    //       const Center(child: CircularProgressIndicator()),
                    //   errorWidget: (context, url, error) =>
                    //       const Icon(Icons.error),
                    // ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
