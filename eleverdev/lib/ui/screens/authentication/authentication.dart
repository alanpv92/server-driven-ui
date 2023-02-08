import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/ui/widgets/authentication/welcome_heading.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQueryHelper(context).safeBlockHorizontal * 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [WelcomeHeading()],
          ),
        ),
      )),
    );
  }
}
