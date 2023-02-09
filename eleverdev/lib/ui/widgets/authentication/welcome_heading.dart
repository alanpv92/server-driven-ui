import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:flutter/material.dart';

class WelcomeHeading extends StatelessWidget {
  const WelcomeHeading({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQueryHelper(context).safeBlockVertical * 5),
      child:
          Text(TextManger.instance.heading, style: theme.textTheme.headline5),
    );
  }
}
