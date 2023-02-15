import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future startDownload() async {
    /*
     
     function to download all images from firebase storage


    */
    try {
      final allImages = await _firebaseStorage.ref().listAll();
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
      fileMetaData[allImages.items[0].name] = metaData.updated;
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

 
}
