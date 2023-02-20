import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermisionService {
  PermisionService._();
  static PermisionService instance = PermisionService._();
  factory PermisionService() => instance;
  Future requestPermision() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
    }
  }

  Future<bool> checkPermision() async {
    if (Platform.isAndroid) {
      var status = await Permission.storage.status;
      return status.isGranted == true;
    }
    return true;
  }
}
