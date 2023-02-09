import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/ui/widgets/authentication/welcome_heading.dart';
import 'package:eleverdev/ui/widgets/common/custom_text_form_field.dart';
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
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const WelcomeHeading(),
              Card(
                child: Container(
                  
                  child: const CustomTextFormField(hintText: 'email'),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
