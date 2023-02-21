import 'package:easy_localization/easy_localization.dart';

class AuthTextManger {
  final String heading = tr('auth_heading');
  final String authEmailHint = 'email';
  final String authPasswordHint = 'password';
  final String authCreateAccount = tr('auth_create_account');
  final String authLoginRedirect = tr('auth_login_redirect');
  final String authConfirmPasswordHint = 'confirm password';
  final String authLogInButton = 'Sign In';
  final String authRegisterButton = "Sign Up";
}

class CommonTextManger {
  final String appBarTitle = "Elever-Dev";
  final String splashTitle = "Elever Dev";
  final String errorText = tr('show_tost_error');
  final String noData = tr('no_data');
  final String errorScreenContent = tr('error_page_content');
  final String tapToRetry = tr('tap_to_retry');
}

class TextManger with AuthTextManger, CommonTextManger {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
