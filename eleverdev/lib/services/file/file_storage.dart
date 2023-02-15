import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageService {
  late Directory _directory;
  FileStorageService._();
  static FileStorageService instance = FileStorageService._();
  factory FileStorageService() => instance;

  initFileStorageService() async {
    _directory = await getApplicationDocumentsDirectory();
  }

  File getApplicationImageStorageFile({required fileName}) {
    final path = getApplicatonImageStoragePath(fileName: fileName);
    return File(path);
  }

  String getApplicatonImageStoragePath({required fileName}) {
    return "${_directory.path}/images/$fileName";
  }

  Future<bool> checkIfApplicationImageStorageIsInit() async {
    final path = "${_directory.path}/images";
    final status = await Directory(path).exists();
    return status;
  }
}
