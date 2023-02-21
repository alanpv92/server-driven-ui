import 'dart:io';
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
    return cachedControllerProvider.isCache
        ? Image.file(
            key: UniqueKey(),
            File(
                "${cachedControllerProvider.imageBasePath}$id${AppManager.firebaseStorageFormat}"),
            height: cardImageCons?.getHeight,
            width: cardImageCons?.getWidth,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          )
        : Image.network(
            key: UniqueKey(),
            "${cachedControllerProvider.imageBasePath}$id${AppManager.firebaseStorageFormat}?alt=media",
            height: cardImageCons?.getHeight,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            width: cardImageCons?.getWidth,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            });
  }
}
