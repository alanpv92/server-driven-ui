import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/data/models/card_config.dart';
import 'package:eleverdev/helpers/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCachedImage extends StatelessWidget {
  final String id;
  final CardImageCons? cardImageCons;
  const CustomCachedImage(
      {super.key, required this.id, required this.cardImageCons});

  @override
  Widget build(BuildContext context) {
    final cachedControllerProvider = Provider.of<CacheController>(context);
    return cachedControllerProvider.isloading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : cachedControllerProvider
                    .imageFiles["$id${AppManager.FirebaseStorageFormat}"] ==
                null
            ? const Center(
                child: Icon(Icons.error),
              )
            : Image.file(
                cachedControllerProvider
                    .imageFiles["$id${AppManager.FirebaseStorageFormat}"]!,
                height: cardImageCons?.getHeight,
                width: cardImageCons?.getWidth,
              );
  }
}
