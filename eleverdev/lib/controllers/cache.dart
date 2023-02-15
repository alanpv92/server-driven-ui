import 'dart:developer';
import 'dart:io';

import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:eleverdev/services/firebase/firebase_storage.dart';

class CacheController extends BaseController {
  CacheController._() {
    isloading = true;
  }
  static CacheController instance = CacheController._();
  factory CacheController() => instance;
  final FileStorageService _fileStorageService = FileStorageService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  late Map<String, File> imageFiles = {};

  loadImages() async {
    //  await _fileStorageService.deleteDirectory();
    final status =
        await _fileStorageService.checkIfApplicationImageStorageIsInit();

    if (!status) {
      await _firebaseStorageService.startDownload();
    }
    imageFiles = await _fileStorageService.loadAllImageFilePath();
    await checkIfDataIsConsistent();
    changeLoadingStatus(false);
  }

  verifyState() {}

  checkIfDataIsConsistent() async {
    final Map<String, DateTime?> firebaseMetaData =
        await _firebaseStorageService.getFileMetadatas();

    final Map<String, DateTime> fileMetaData =
        await _fileStorageService.getFileMetaData();
    imageFiles.forEach((key, value) async {
      if (firebaseMetaData[key] != null &&
          fileMetaData[key]!.isAtSameMomentAs(firebaseMetaData[key]!)) {
        await _firebaseStorageService.downloadFile(fileName: key);
        imageFiles[key] = _fileStorageService.getFile(fileName: key);
      }
    });
  }
}
