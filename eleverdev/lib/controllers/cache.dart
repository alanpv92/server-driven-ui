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
    /*
      This functions loads all image for cards
    */
    final status = await _fileStorageService
        .checkIfApplicationImageStorageIsInit(); //used to check if images are loaded
    log('status is $status');
    if (!status) {
      await _firebaseStorageService
          .startDownload(); // if images are not loaded ,it is downloaded from firebsae
    }
    imageFiles = await _fileStorageService
        .loadAllImageFilePath(); //loads image from loacal storage

    // await checkIfDataIsConsistent(); //function to check if data in local storage is consistent with data in firebase
    changeLoadingStatus(false);
  }

  checkIfDataIsConsistent() async {
    /*
    function to check if data is consistent
    */
    bool shouldRebuild = false;
    final Map<String, DateTime?> firebaseMetaData =
        await _firebaseStorageService.getFileMetadatas();

    final Map<String, DateTime> fileMetaData =
        await _fileStorageService.getFileMetaData();
    imageFiles.forEach((key, value) async {
      if (firebaseMetaData[key] != null &&
          fileMetaData[key]!.isAtSameMomentAs(firebaseMetaData[key]!)) {
        shouldRebuild = true;
        await _firebaseStorageService.downloadFile(fileName: key);
        imageFiles[key] = _fileStorageService.getFile(fileName: key);
      }
    });
    log('i am being run');
    if (shouldRebuild) {
      notifyListeners();
    }
  }

  cacheControllerDisposer() {
    imageFiles = {};
    isloading = false;
  }
}
