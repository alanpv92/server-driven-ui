import 'package:eleverdev/controllers/retry.dart';
import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:flutter/material.dart';

class RetryScreen extends StatelessWidget {
  final String routeName;
  const RetryScreen({super.key, required this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQueryHelper(context).safeBlockHorizontal * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  TextManger.instance.errorScreenContent,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              TextButton(
                  onPressed: () {
                    RetryController.instance.retry(routeName: routeName);
                  },
                  child: Text(TextManger.instance.tapToRetry))
            ],
          ),
        ),
      )),
    );
  }
}
