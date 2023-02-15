import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:eleverdev/services/file/file_storage.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future startDownload() async {
    try {
      final allImages = await _firebaseStorage.ref().listAll();
      for (int i = 0; i < allImages.items.length; i++) {
        final file = FileStorageService.instance.getApplicationImageStorageFile(
            fileName: allImages.items[i].fullPath);
        // final downloadTask = allImages.items[0].writeToFile(file);
        // await downloadTask;
      }
      
      // downloadTask.snapshotEvents.listen((taskSnapshot) {
      //   switch (taskSnapshot.state) {
      //     case TaskState.running:
      //       log('i am being run');
      //       break;
      //     case TaskState.paused:
      //       log('i am being pasued');
      //       break;
      //     case TaskState.success:
      //       log('i am being done');
      //       break;
      //     case TaskState.canceled:
      //       log('i am being cancelld');
      //       break;
      //     case TaskState.error:
      //       log('i am being error');
      //       break;
      //   }
      // });

      // final allImages = await _firebaseStorage.ref().listAll();
      // final appDocDir = await getApplicationDocumentsDirectory();
      // for (int i = 0; i < allImages.items.length; i++) {
      //   final filePath =
      //       "${appDocDir.absolute}/images/${allImages.items[i].fullPath}";
      //   final file = File(filePath);
      //   final downloadTask = allImages.items[i].writeToFile(file);
      //   downloadTask.whenComplete(() => log('completed'));
      // }
      // final metaData = await allImages.items[3].getMetadata();
      // final data = await allImages.items[0].writeToFile();

      // log(metaData.timeCreated.toString());
    } catch (e) {
      log('i am being rundasdsadsadsadsadsadsadsadsadsadsadsa');
      log(e.toString());
    }
  }
}
