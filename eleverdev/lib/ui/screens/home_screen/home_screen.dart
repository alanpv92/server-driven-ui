import 'dart:developer';

import 'package:eleverdev/controllers/authentication.dart';
import 'package:eleverdev/controllers/home_page.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:eleverdev/ui/widgets/home/home_screen_list_view.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeScreenController =
        Provider.of<HomePageController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(TextManger.instance.appBarTitle),
      ),
      body: StreamBuilder(
        stream: homeScreenController.getSnapShot(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(TextManger.instance.errorText),
            );
          } else if (snapshot.connectionState == ConnectionState.active &&
              snapshot.hasData) {
            homeScreenController.populateListView(snapshot.data!.docs);
            return  HomeScreenListView(
              key: UniqueKey(),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
