import 'package:eleverdev/controllers/app.dart';
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
    /*
    This function initializes all the controllers and keys for Authentication
    This function also populates authFields list with required CustomTextFormField widgets
    */
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
    /*
     This function toggles between auth modes (login and registration)
     if authmode is register it adds an confirm password field to authFields
     if authmode is login then it removes the added field from authFields
    */

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
    /*
    
      This function returns submit button text based on authMode

    */
    if (authMode == AuthMode.login) {
      return TextManger.instance.authLogInButton;
    }
    return TextManger.instance.authRegisterButton;
  }

  getAuthStatusChangeText() {
    /*
      This function returns text for changing authMode
    */

    if (authMode == AuthMode.login) {
      return TextManger.instance.authCreateAccount;
    }
    return TextManger.instance.authLoginRedirect;
  }

  authenticate() async {
    /*

     This function is used to authenticate user,
     function validates form,if any field is empty shows an warning and prevent user from authenticating
     if authmode is login loginUser function is called else createAccount function is called
     both these functions return firebaseResponse which contains status if tells if it was sucess or failure
     if it was failure error message is shown else user is logged in

    */
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
    /*

   this function is used to clear all controller after login

    */
    authFields.clear();
    emailController.dispose();
    passwordController.dispose();
    authMode = AuthMode.login;
  }

  onlogOut() {
    /*
    
    This function is used to log out user


    */
    AppController.instance.disposeApp();
    _firebaseAuthService.logout();
  }
}
