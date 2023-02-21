import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileStorageService {
  //creates an private constructor of fileStorageService
  FileStorageService._();
  //creates an static instance of fileStorageService
  static FileStorageService instance = FileStorageService._();
  // creates an factory constructor which returns the static instance
  factory FileStorageService() => instance;

  late Directory _directory;
  late String _dirPath;

  Future initFileStorageService() async {
    //function used to initialize directory and directory path when app starts
    _directory = await getApplicationDocumentsDirectory();
    _dirPath = '${_directory.path}/images/';
  }

  //getter to get _dirPath
  String get getFileImageBasePath => _dirPath;

  File getApplicationImageStorageFile({required fileName}) {
    //function used to get file with given name
    final path = getApplicatonImageStoragePath(fileName: fileName);
    return File(path);
  }

  String getApplicatonImageStoragePath({required fileName}) {
    //function to get path of file with given name;
    return "$_dirPath$fileName";
  }

  Future<bool> checkIfApplicationImageStorageIsInit() async {
    //function to check if image directory is present
    final status = await Directory(_dirPath).exists();
    return status;
  }

  loadAllImageFilePath() async {
    //function used to load all files from image directory
    final Map<String, File> imageFiles = {};
    //creates an directory with path of image directory
    final Directory directory = Directory(_dirPath);
    //list all the images in image directory
    final allFiles = directory.listSync();

    for (int i = 0; i < allFiles.length; i++) {
      //creates an file from file path
      final File file = File(allFiles[i].path);
      //get image name from file path
      final String filename = file.path.split('/').last;
      //saves the file with image name as key in imageFiles
      imageFiles[filename] = file;
    }
    return imageFiles;
  }

  getFileMetaData() { 
    // function used to get metadata of files in image directoy
    final Map<String, DateTime> imageFiles = {};
    //creates directory for image directory
    final Directory directory = Directory(_dirPath);
    //list all files in image directory
    final files = directory.listSync();
    for (var element in files) {
      //gets when was the file last changed
      final DateTime modifed = element.statSync().changed;
      //saves chenged date with image name as key in imageFiles
      imageFiles[element.path.split('/').last] = modifed;
    }
    return imageFiles;
  }

  File getFile({required String fileName}) { 
    //function used to get a single file
    final path = "$_dirPath$fileName";
    File file = File(path);
    return file;
  }
}
