import 'package:easy_localization/easy_localization.dart';

class AuthTextManger {
 final String heading = tr('auth_heading');
}

class TextManger with AuthTextManger {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
