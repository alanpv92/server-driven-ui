import 'package:eleverdev/controllers/authentication.dart';
import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/ui/widgets/authentication/auth_box.dart';
import 'package:eleverdev/ui/widgets/authentication/welcome_heading.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQueryHelper(context).safeBlockVertical*100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const WelcomeHeading(),
                const AuthBox(),
                const Spacer(),
                Consumer<AuthenticationController>(
                  builder: (context, value, child) {
                    return TextButton(
                        onPressed: value.changeAuthMode,
                        child: Text(value.getAuthStatusChangeText()));
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
