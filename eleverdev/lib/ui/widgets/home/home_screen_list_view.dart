import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/ui/widgets/home/home_screen_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenListView extends StatelessWidget {
  const HomeScreenListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homePageControllerProvider = Provider.of<HomePageController>(context,listen: false);
    return ListView.builder(
      itemBuilder: (context, index) {
        return HomeScreenListItem(
          homeScreenItem: homePageControllerProvider.cards[index],
        );
      },
      itemCount: homePageControllerProvider.cards.length,
    );
  }
}
