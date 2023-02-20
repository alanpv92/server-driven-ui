import 'dart:developer';

import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:eleverdev/services/firebase/firebase_storage.dart';
import 'package:eleverdev/services/permisions/permision.dart';

class CacheController extends BaseController {
  CacheController._();
  static CacheController instance = CacheController._();
  factory CacheController() => instance;
  final FileStorageService _fileStorageService = FileStorageService();
  final FirebaseStorageService _firebaseStorageService =
      FirebaseStorageService();
  late bool isCache;
  late String imageBasePath;
  setImageBasePath() async {
    final status = await _fileStorageService
        .checkIfApplicationImageStorageIsInit(); // checks if directory for image exists
    log(status.toString());
    isCache =
        status; //set the status of image directoy to isCache varible,which can be used to determine wheater to download images or check for consistency
    if (!status) {
      imageBasePath = FirebaseManger
          .firebaseStorageBaseUrl; //if image directory does not exist then path of image is set to firebase url
    } else {
      imageBasePath = _fileStorageService
          .getFileImageBasePath; // if image directory exists then path of image is set to file path from local storage
    }
  }

  performCacheAction() async {
    if (!isCache) {
      await PermisionService.instance.requestPermision();
      final status = await PermisionService.instance.checkPermision();
      if (status) {
     
        _firebaseStorageService.startDownloadUsingIsolate();
      }
    } else {
      checkForConsistency();
    }
  }

  checkForConsistency() async {
    final Map<String, DateTime?> firebaseMetaData =
        await _firebaseStorageService.getFileMetadatas();
    final Map<String, DateTime> fileMetaData =
        await _fileStorageService.getFileMetaData();

    firebaseMetaData.forEach((key, value) async {
      if (firebaseMetaData[key] != null &&
          fileMetaData[key] != null &&
          fileMetaData[key]!.isBefore(firebaseMetaData[key]!)) {
        await _firebaseStorageService.downloadFile(fileName: key);
        notifyListeners();
      }
    });
  }

  cacheControllerDisposer() {}
}
