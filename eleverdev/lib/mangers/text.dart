class AuthTextManger {
 final String heading = 'Welcome Back';
}

class TextManger with AuthTextManger {
  TextManger._();
  static TextManger instance = TextManger._();
  factory TextManger() => instance;
}
