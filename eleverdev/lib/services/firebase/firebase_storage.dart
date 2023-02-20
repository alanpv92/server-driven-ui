import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eleverdev/firebase_options.dart';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:http/http.dart' show get;
import 'package:isolate_handler/isolate_handler.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future startDownload() async {
    /*
     
     function to download all images from firebase storage

    */
    try {
      final allImages = await _firebaseStorage
          .ref()
          .listAll(); // lists all images in firebase storage
      if (Platform.isAndroid) {
        // creates an directory if the platfrom is andriod
        await Directory(FileStorageService.instance.getFileImageBasePath)
            .create();
      }
      for (int i = 0; i < 3; i++) {
        final file = FileStorageService.instance.getApplicationImageStorageFile(
            fileName:
                allImages.items[i].fullPath); //creates a path for the file
        final downloadTask = allImages.items[i]
            .writeToFile(file); //starts downloading image to that file
        await downloadTask;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, DateTime?>> getFileMetadatas() async {
    /*


     function to get metaData from firebase

    */
    final Map<String, DateTime?> fileMetaData = {};
    final allImages = await _firebaseStorage.ref().listAll();

    for (int i = 0; i < allImages.items.length; i++) {
      final metaData = await allImages.items[i].getMetadata();
      fileMetaData[allImages.items[i].name] = metaData.updated;
    }

    return fileMetaData;
  }

  Future downloadFile({required String fileName}) async {
    /*
     
     function to download single file
   
    */
    final ref = _firebaseStorage.ref().child(fileName);
    final file = FileStorageService.instance
        .getApplicationImageStorageFile(fileName: fileName);
    final downloadTask = ref.writeToFile(file);
    await downloadTask;
  }

  Future startDownloadUsingIsolate() async {
    /*
       function to start download process using isolates
    */
    final isolates = IsolateHandler();
    isolates.spawn(startDownLoadProcess);
  }

  // startDownloadUsingUrl(
  //     {required String fileName, required String filePath}) async {
  //   final Map<String, String> data = {};
  //   data['fileName'] = fileName;
  //   final conData = json.encode(data);
  //   await flutterCompute(startDowloadProcessUsingUrl, conData);
  // }
}

// @pragma('vm:entry-point')
// startDowloadProcessUsingUrl(String data) async {
//   try {
//     final conData = json.decode(data);
//     // final uri = Uri.parse(
//     //     "${FirebaseManger.firebaseStorageBaseUrl}${conData['fileName']}?alt=media");
//     final uri = Uri.parse('https://picsum.photos/200/300');
//     var path = await getApplicationDocumentsDirectory();
//     final filePath = "${path.path}/images/${conData['fileName']}";
//     log('path of file $filePath');
//     final file = File(filePath);
//     log('3333333333333333');
//     var response = await get(uri);
//     log('55555555555555');
//     file.writeAsBytesSync(response.bodyBytes);

//     log(conData.toString());
//   } catch (e) {
//     log('error is $e');
//   }
// }

startDownLoadProcess(Map<String, dynamic> data) async {
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions
          .currentPlatform); //initializes firebase app for the spawned isolate

  final FirebaseStorage firebaseStorage = FirebaseStorage
      .instance; //creates an instance of firebase storage for the spawned isolate

  final FileStorageService fileStorageService =
      FileStorageService(); //creates an instance of file storage service for the spawned isolate
  await fileStorageService
      .initFileStorageService(); // initilized the firebase storage service for spawned isolate

  try {
    final allImages = await firebaseStorage.ref().listAll();// lists all images in firebase storage
    if (Platform.isAndroid) {
      await Directory(FileStorageService.instance.getFileImageBasePath)
          .create();// creates an directory if the platfrom is andriod
    }
    for (int i = 0; i < allImages.items.length; i++) {
      final file = FileStorageService.instance.getApplicationImageStorageFile(
          fileName: allImages.items[i].fullPath); 
      final downloadTask = allImages.items[i].writeToFile(file); //starts downloading the image to the file
      downloadTask.whenComplete(() {});
    }
  } catch (e) {
    log("error is $e");
  }
}
