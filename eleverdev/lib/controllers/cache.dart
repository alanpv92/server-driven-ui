import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:eleverdev/services/firebase/firebase_storage.dart';

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
    final status =
        await _fileStorageService.checkIfApplicationImageStorageIsInit();
    isCache = status;
    if (!status) {
      _firebaseStorageService.startDownload();
      imageBasePath = FirebaseManger.firebaseStorageBaseUrl;
    } else {
      imageBasePath = _fileStorageService.getFileImageBasePath;
    }
  }

  performCacheAction() {
    if (!isCache) {
      _firebaseStorageService.startDownload();
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
