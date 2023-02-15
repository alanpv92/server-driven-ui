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

  loadAllImageFilePath() async {
    final Map<String, File> imageFiles = {};
    final path = "${_directory.path}/images";
    final Directory directory = Directory(path);

    final allFiles = directory.listSync();
    for (int i = 0; i < allFiles.length; i++) {
      final File file = File(allFiles[i].path);
      final String filename = file.path.split('/').last;
      imageFiles[filename] = file;
    }
    return imageFiles;
  }

  getFileMetaData() {
    final Map<String, DateTime> imageFiles = {};
    final path = "${_directory.path}/images";
    final Directory directory = Directory(path);
    final files = directory.listSync();
    for (var element in files) {
      final DateTime modifed = element.statSync().modified;
      imageFiles[element.path.split('/').last] = modifed;
    }
    return imageFiles;
  }

 File getFile({required String fileName})  {
    final path = "${_directory.path}/images/$fileName";
    File file = File(path);
    return file;
  }

  // Future deleteDirectory() async {
  //   // final path = "${_directory.path}/images";
  //   // final dir = Directory(path);
  //   // await dir.delete(recursive: true);
  // }
}
