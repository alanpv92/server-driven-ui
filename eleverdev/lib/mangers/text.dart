import 'package:easy_localization/easy_localization.dart';

class AuthTextManger {
  final String heading = tr('auth_heading');
  final String authEmailHint = 'email';
  final String authPasswordHint = 'password';
}

class TextManger with AuthTextManger {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
