import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/data/enum/enums.dart';
import 'package:eleverdev/data/models/firebase_response.dart';
import 'package:eleverdev/helpers/snack_bar.dart';

import 'package:eleverdev/mangers/text.dart';
import 'package:eleverdev/services/firebase/firebase_auth.dart';
import 'package:eleverdev/ui/widgets/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthenticationController extends BaseController {
  late GlobalKey<FormState> authFormKey;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final List<CustomTextFormField> authFields = [];

  AuthMode authMode = AuthMode.login;
  final FirebaseAuthService _firebaseAuthService = FirebaseAuthService();
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

  authenticate() async {
    if (authFormKey.currentState!.validate()) {
      late FirebaseResponse firebaseResponse;
      changeLoadingStatus(true);
      if (authMode == AuthMode.registration) {
        firebaseResponse = await _firebaseAuthService.createAccount(
            email: emailController.text.trim(),
            password: passwordController.text);
      } else {
        firebaseResponse = await _firebaseAuthService.loginUser(
            email: emailController.text.trim(),
            password: passwordController.text);
      }
      if (!firebaseResponse.status) {
        ShowSnackBar.showError(
            errorMessage:
                firebaseResponse.errorMessage ?? "some error occured");
      } else {
        authControllerDisposer();
      }
      changeLoadingStatus(false);
    }
  }

  authControllerDisposer() {
    authFields.clear();
    emailController.dispose();
    passwordController.dispose();
    authMode = AuthMode.login;
  }

  onlogOut() {
    _firebaseAuthService.logout();
  }
}
