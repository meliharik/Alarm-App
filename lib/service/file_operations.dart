import 'dart:io';
import 'package:alarmapp/models/image_model.dart';
import 'package:crypter/crypter.dart';
import 'package:device_identifier/device_identifier.dart';
import 'package:path_provider/path_provider.dart';

class FileOperations {
  static FileOperations fileOperations;
  Directory directory;
  Directory trashPath;
  Directory restorePath = Directory("/storage/emulated/0/GeriYüklenenler");
  String deviceID;
  FileOperations._() {
    getApplicationDocumentsDirectory().then((value) {
      directory = Directory('${value.path}/Photos');
      trashPath = Directory('${value.path}/Trash');
      controlDirectory();
      controlTrashImages();
    });
    getDeviceID();
  }

  getDeviceID() async {
    deviceID = await DeviceIdentifier.deviceId;
    print(deviceID);
  }

  controlDirectory() async {
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    if (!await restorePath.exists()) {
      await restorePath.create(recursive: true);
    }
    if (!await trashPath.exists()) {
      await trashPath.create(recursive: true);
    }
  }

  static getInstance() {
    if (fileOperations == null) {
      fileOperations = new FileOperations._();
    }
    return fileOperations;
  }

  moveToTrash(List imagePaths) async {
    for (var path in imagePaths) {
      String imageName = getImageNameFromPath(path);
      await File(path).copy('${trashPath.path}/$imageName');
      await deleteImage(path);
    }
  }

  getTrashImages() async {
    List fileList = trashPath.listSync();
    List tempList = [];
    for (File file in fileList) {
      var tempByteData = await file.readAsBytes();
      var decryptedData = Crypter.decrypt(tempByteData, deviceID);
      tempList.add(ImageModel(file.path, decryptedData));
    }
    return tempList;
  }

  saveImage(List images) async {
    for (var image in images) {
      dynamic byteData = await image.getByteData(quality: 75);
      var uintData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      var encrypted = Crypter.encrypt(uintData, deviceID);
      File('${directory.path}/${image.name}')
          .writeAsBytes(encrypted)
          .then((value) => print(value));
    }
    return await getImagesLocal();
  }

  deleteImage(String path) async {
    return await File(path).delete();
  }

  deleteImageList(List imageList) async {
    for (var path in imageList) {
      await File(path).delete();
    }
    return await getImagesLocal();
  }

  deleteAllImages() async {
    List fileList = Directory("${directory.path}/").listSync();
    for (File file in fileList) {
      file.delete();
    }
    fileList = Directory("${directory.path}/").listSync();
    if (fileList.length != 0) {
      return false;
    } else {
      return true;
    }
  }

  getImagesLocal() async {
    List fileList = directory.listSync();
    List tempList = [];
    for (File file in fileList) {
      var tempByteData = await file.readAsBytes();
      var decryptedData = Crypter.decrypt(tempByteData, deviceID);
      tempList.add(ImageModel(file.path, decryptedData));
    }
    return tempList;
  }

  getImageNameFromPath(String path) {
    var pathElement = path.split("/");
    return pathElement[pathElement.length - 1];
  }

  getImageLocal(String path) async {
    File file = File(path);
    var byteData = await file.readAsBytes();
    var image = ImageModel(
        getImageNameFromPath(path), Crypter.decrypt(byteData, deviceID));
    return image;
  }

  restoreImage(List images) async {
    for (var image in images) {
      var restoredImage = await getImageLocal(image);
      File('${restorePath.path}/${restoredImage.imageName}')
          .writeAsBytes(restoredImage.imageData)
          .then((value) => print(value));
    }
    await deleteImageList(images);
    return await getImagesLocal();
  }

  controlTrashImages() async {
    List controlList = trashPath.listSync();
    DateTime nowDate = DateTime.now();
    for (File file in controlList) {
      Duration diff = nowDate.difference(file.lastModifiedSync());
      print(file.lastModifiedSync().toString());
      if (diff.inDays > 30) {
        file.delete().then((value) => print("File Deleted"));
      }
    }
  }

  getTrashImageDates() async {
    List controlList = trashPath.listSync();
    List dates = [];
    for (File file in controlList) {
      dates.add(file.lastModifiedSync());
    }
    return dates;
  }
}
