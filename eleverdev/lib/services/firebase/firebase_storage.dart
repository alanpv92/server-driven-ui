import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:eleverdev/firebase_options.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import "package:flutter_isolate/flutter_isolate.dart";
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future startDownload() async {
    /*
     
     function to download all images from firebase storage


    */
    try {
      final allImages = await _firebaseStorage.ref().listAll();
      if (Platform.isAndroid) {
        await Directory(FileStorageService.instance.getFileImageBasePath)
            .create();
      }
      for (int i = 0; i < allImages.items.length; i++) {
        final file = FileStorageService.instance.getApplicationImageStorageFile(
            fileName: allImages.items[i].fullPath);
        final downloadTask = allImages.items[i].writeToFile(file);
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
    final revicePort = ReceivePort();

    await FlutterIsolate.spawn(startDownLoadProcess, revicePort.sendPort);
  }
}

startDownLoadProcess(SendPort sendPort) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  final FileStorageService fileStorageService = FileStorageService();
  await fileStorageService.initFileStorageService();

  try {
    final allImages = await firebaseStorage.ref().listAll();
    for (int i = 0; i < allImages.items.length; i++) {
      final file = FileStorageService.instance.getApplicationImageStorageFile(
          fileName: allImages.items[i].fullPath);
      final downloadTask = allImages.items[i].writeToFile(file);
      downloadTask.whenComplete(() {
        log('completed----------------');
      });
    }
  } catch (e) {
    log(e.toString());
  }
}
