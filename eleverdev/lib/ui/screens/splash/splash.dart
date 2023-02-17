import 'package:eleverdev/controllers/app.dart';
import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:eleverdev/ui/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: AppController.instance.initApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          } else {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal:
                        MediaQueryHelper(context).safeBlockHorizontal * 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      TextManger.instance.splashTitle,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQueryHelper(context).safeBlockHorizontal * 50,
                      child: const LinearProgressIndicator(
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )),
    );
  }
}
