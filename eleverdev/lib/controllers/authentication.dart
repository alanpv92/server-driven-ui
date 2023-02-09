import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/data/enum/enums.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:eleverdev/ui/widgets/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthenticationController extends BaseController {
  late GlobalKey<FormState> authFormKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final List<CustomTextFormField> authFields = [];

  AuthMode authMode = AuthMode.login;

  initAuthBox() {
    authFormKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    authFields.addAll([
      CustomTextFormField(
        hintText: TextManger.instance.authEmailHint,
        controller: emailController,
      ),
      CustomTextFormField(
        hintText: TextManger.instance.authPasswordHint,
        controller: passwordController,
        ispass: true,
      )
    ]);
  }

  disposeAuthBox() {
    emailController.dispose();
    passwordController.dispose();
  }

  void changeAuthMode() {
    authFormKey.currentState!.reset();
    if (authMode == AuthMode.login) {
      authFields.add(CustomTextFormField(
        hintText: TextManger.instance.authConfirmPasswordHint,
        ispass: true,
        customVaildator: (value) {
          if (value == null || value.isEmpty) {
            return "this field is required";
          }
          if (value != passwordController.text) {
            return "passwords do not match";
          }
          return null;
        },
      ));
      authMode = AuthMode.registration;
    } else {
      if (authFields.length == 3) {
        authFields.removeAt(2);
      }
      authMode = AuthMode.login;
    }

    notifyListeners();
  }

  getAuthButtonText() {
    if (authMode == AuthMode.login) {
      return TextManger.instance.authLogInButton;
    }
    return TextManger.instance.authRegisterButton;
  }

  getAuthStatusChangeText() {
    if (authMode == AuthMode.login) {
      return TextManger.instance.authCreateAccount;
    }
    return TextManger.instance.authLoginRedirect;
  }

  authenticate() {
    if (authFormKey.currentState!.validate()) {
      
    }
  }
}
