import 'package:eleverdev/controllers/authentication.dart';
import 'package:eleverdev/helpers/media_query.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthBox extends StatefulWidget {
  const AuthBox({super.key});

  @override
  State<AuthBox> createState() => _AuthBoxState();
}

class _AuthBoxState extends State<AuthBox> {
  @override
  void initState() {
    Provider.of<AuthenticationController>(context, listen: false).initAuthBox();
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<AuthenticationController>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authControllerProvider = Provider.of<AuthenticationController>(context);
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      child: Form(
        key: authControllerProvider.authFormKey,
        child: Column(
          children: [
           ...authControllerProvider.authFields,
            Container(
                margin: EdgeInsets.symmetric(
                  vertical: MediaQueryHelper(context).safeBlockVertical * 2,
                ),
                child: SizedBox(
                  width: MediaQueryHelper(context).safeBlockHorizontal * 40,
                  height: MediaQueryHelper(context).safeBlockVertical * 4,
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      onPressed: authControllerProvider.authenticate,
                      child:  Text(authControllerProvider.getAuthButtonText())), //add to text manger
                ))
          ],
        ),
      ),
    );
  }
}
