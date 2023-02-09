import 'package:flutter/material.dart';

class BaseController extends ChangeNotifier {
  bool isloading = false;
  changeLoadingStatus(bool newStatus) {
    isloading = newStatus;
    notifyListeners();
  }
}
