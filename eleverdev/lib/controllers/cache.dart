import 'package:eleverdev/controllers/base.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:eleverdev/services/firebase/firebase_storage.dart';
import 'package:eleverdev/services/permisions/permision.dart';

class CacheController extends BaseController {
  //creates an instance of CacheController
  CacheController._();
  //creates an static intance of CacheController 
  static CacheController instance = CacheController._();
  //returns the static instance of AppController
  factory CacheController() => instance;
  //creates an instance of FileStorageService
  final FileStorageService _fileStorageService = FileStorageService();
  //creates an instance of FirebaseStorageService
  final FirebaseStorageService _firebaseStorageService =FirebaseStorageService();
  late bool isCache;
  late String imageBasePath;
  setImageBasePath() async {
    // checks if directory for image exists
    final status = await _fileStorageService.checkIfApplicationImageStorageIsInit(); 
    //set the status of image directoy to isCache varible,which can be used to determine wheater to download images or check for consistency
    isCache =status; 
    if (!status) {
       //if image directory does not exist then path of image is set to firebase url
      imageBasePath = FirebaseManger.firebaseStorageBaseUrl;
    } else {
      // if image directory exists then path of image is set to file path from local storage
      imageBasePath = _fileStorageService.getFileImageBasePath; 
    }
  }

  performCacheAction() async {
    //function checks if cache data is available or not,and performs actions based on that
    if (!isCache) {
      //if cache data is not available then it asks for permision and if permision is granted ,starts downloading images
      await PermisionService.instance.requestPermision();
      final status = await PermisionService.instance.checkPermision();
      if (status) {
        _firebaseStorageService.startDownload();
      }
    } else {
      //if cache data is availble then, it checks if data is consistent
      checkForConsistency();
    }
  }

  checkForConsistency() async {
    //gets  meta data from firebase 
    final Map<String, DateTime?> firebaseMetaData =
        await _firebaseStorageService.getFileMetadatas();
    //gets meta data from file directory   
    final Map<String, DateTime> fileMetaData =
        await _fileStorageService.getFileMetaData();
      
   //compares both meta data and if any file is out of sync ,then it is downloaded
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
