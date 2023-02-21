import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:eleverdev/mangers/firebase.dart';
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:http/http.dart' show get;
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  //creates an instance of firebase storage
  final _firebaseStorage = FirebaseStorage.instance;
  Future startDownload() async {
    //function to download all images from firebase storage
    try {
      // lists all images in firebase storage
      final allImages = await _firebaseStorage.ref().listAll();
      // creates an directory to save images
      await Directory(FileStorageService.instance.getFileImageBasePath)
          .create();
      for (int i = 0; i < allImages.items.length; i++) {
        //function to  download each image from firebase storage
        await startDownloadUsingUrl(fileName: allImages.items[i].fullPath);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, DateTime?>> getFileMetadatas() async {
    //function to get metaData from firebase
    final Map<String, DateTime?> fileMetaData = {};
    // lists all images in firebase storage
    final allImages = await _firebaseStorage.ref().listAll();
    for (int i = 0; i < allImages.items.length; i++) {
      //gets metadata of each image and stores in metaData varible
      final metaData = await allImages.items[i].getMetadata();
      //saves the updated time of file from metaData to fileMetaData
      fileMetaData[allImages.items[i].name] = metaData.updated;
    }
    return fileMetaData;
  }

  Future downloadFile({required String fileName}) async {
    // function to download single file
    // lists all images in firebase storage
    final ref = _firebaseStorage.ref().child(fileName);
    // gets file for saving image
    final file = FileStorageService.instance
        .getApplicationImageStorageFile(fileName: fileName);
    // starts downloading image to file
    final downloadTask = ref.writeToFile(file);
    await downloadTask;
  }

  startDownloadUsingUrl({required String fileName}) async {
    // start downloading each image from firebase storage
    final Map<String, String> data = {};
    data['fileName'] = fileName;
    //converts map to string
    final conData = json.encode(data);
    //spwans an isolate that downloads the image
    await flutterCompute(startDowloadProcessUsingUrl, conData);
  }
}

@pragma('vm:entry-point')
startDowloadProcessUsingUrl(String data) async {
  try {
    //function that runs in seperate isolate to download image
    //converts data from string to map
    final conData = json.decode(data);
    //creates uri to download image from firebase
    final uri = Uri.parse(
        "${FirebaseManger.firebaseStorageBaseUrl}${conData['fileName']}?alt=media");
    //get path of directory to save image
    var path = await getApplicationDocumentsDirectory();
    //creates a file path with directory path and filename
    final filePath = "${path.path}/images/${conData['fileName']}";
    //creates a file using the file path
    final file = File(filePath);
    //downloads the data using uri
    var response = await get(uri);
    //writes to data as bytes to file
    file.writeAsBytesSync(response.bodyBytes);
  } catch (e) {
    log('error is $e');
  }
}
