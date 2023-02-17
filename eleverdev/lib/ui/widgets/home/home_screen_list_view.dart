import 'dart:developer';

import 'package:eleverdev/controllers/cache.dart';
import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/ui/widgets/home/home_screen_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenListView extends StatefulWidget {
  const HomeScreenListView({super.key});

  @override
  State<HomeScreenListView> createState() => _HomeScreenListViewState();
}

class _HomeScreenListViewState extends State<HomeScreenListView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      CacheController.instance.checkIfDataIsConsistent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homePageControllerProvider =
        Provider.of<HomePageController>(context, listen: false);
    return ListView.builder(
      itemBuilder: (context, index) {
        return HomeScreenListItem(
          cardConfig: homePageControllerProvider.cards[index].cardConfig,
          id: homePageControllerProvider.cards[index].id,
        );
      },
      itemCount: homePageControllerProvider.cards.length,
    );
  }
}
