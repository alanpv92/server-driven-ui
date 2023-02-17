import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageService {
  FileStorageService._();
  static FileStorageService instance = FileStorageService._();
  factory FileStorageService() => instance;

  late Directory _directory;
  late String _dirPath;

  initFileStorageService() async {
    /*
     
     function used to initialize directory and directory path when app starts

    */
    _directory = await getApplicationDocumentsDirectory();
    _dirPath = '${_directory.path}/images/';
  }

  String get getFileImageBasePath=>_dirPath;

  File getApplicationImageStorageFile({required fileName}) {
    /*
     
     function used to get file with given name

    */
    final path = getApplicatonImageStoragePath(fileName: fileName);

    return File(path);
  }

  String getApplicatonImageStoragePath({required fileName}) {
    /*
    function to get path of file with given name;
    */
    return "$_dirPath$fileName";
  }

  Future<bool> checkIfApplicationImageStorageIsInit() async {
    /*
     
     function to check if image directory is present

    */
    final status = await Directory(_dirPath).exists();

    return status;
  }

  loadAllImageFilePath() async {
    /*
     
     function used to load all files from image directory
 
    */
    final Map<String, File> imageFiles = {};
    final Directory directory = Directory(_dirPath);
    final allFiles = directory.listSync();

    for (int i = 0; i < allFiles.length; i++) {
      final File file = File(allFiles[i].path);
      final String filename = file.path.split('/').last;
      imageFiles[filename] = file;
    }
    return imageFiles;
  }

  getFileMetaData() {
    /*  
     function used to get metadata of files in image directoy
    */
    final Map<String, DateTime> imageFiles = {};
    final Directory directory = Directory(_dirPath);
    final files = directory.listSync();
    for (var element in files) {
      final DateTime modifed = element.statSync().changed;
      imageFiles[element.path.split('/').last] = modifed;
    }
    return imageFiles;
  }

  File getFile({required String fileName}) {
    /*
     
     function used to get a single file

    */
    final path = "$_dirPath$fileName";
    File file = File(path);
    return file;
  }
}
