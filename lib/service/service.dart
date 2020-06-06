import 'package:alarmapp/db/user_db.dart';
import 'package:alarmapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypter/crypter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Service {
  static Service _service;
  var db;
  static String uid;
  UserDB _userDB;
  User user;
  Service._() {
    db = Firestore.instance;
    _userDB = UserDB.getInstance();
    getIDKey();
    getUserInfo();
  }

  getUserInfo() async {
    user = await _userDB.getUserInfo();
  }

  getIDKey() async {
    uid = await _userDB.getUID();
  }

  static getInstance() {
    if (_service == null) {
      _service = new Service._();
    }
    return _service;
  }

  login(String email, password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((onError) {
        print(onError);
      });
      uid = result.user.uid;
    } catch (e) {
      uid = null;
    }
    return uid;
  }

  register(String mail, password) async {
    AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: password)
        .catchError((onError) {
      print(onError);
    });
    uid = result.user.uid;
    return result.user.uid;
  }

  addUserDB(name, mail, password) async {
    var data = {
      "uid": uid,
      "name": name,
      "email": mail,
      "password": password,
      "Images": []
    };
    db.collection('Users').document(uid).setData(data);
  }

  addAlarmPass(alarmPass) async {
    db
        .collection('Users')
        .document(uid)
        .setData({'alarmPass': alarmPass}, merge: true);
  }

  uploadImage(Asset asset) async {
    StorageReference _storage = FirebaseStorage.instance.ref();
    final byteData = await asset.getByteData();
    StorageUploadTask storagetaskt = _storage
        .child('Users')
        .child(uid)
        .child(asset.name)
        .putData(byteData.buffer
            .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    await storagetaskt.onComplete;
    addImgNameToDB(asset.name);
  }

  addImgNameToDB(String imgName) async {
    var userRef = db.collection('Users').document(uid);
    var doc = await userRef.get();
    var imgList = doc['Images'];
    imgList.add(imgName);
    userRef.setData({'Images': imgList}, merge: true);
  }

  getImageNames() async {
    var userRef = db.collection('Users').document(uid);
    var doc = await userRef.get();
    return doc['Images'];
  }

  getAllImages() async {
    StorageReference _storage = FirebaseStorage.instance.ref();
    /*var userRef = db.collection('Users').document(uid);
    var doc = await userRef.get();
    var imgNames = doc['Images'];
    */
    var imgNames = await getImageNames();
    var imgUrl = [];
    for (var image in imgNames) {
      var photoUrl = await _storage
          .child('Users')
          .child(uid)
          .child(image)
          .getData(1 * 2048 * 2048);
      //getDownloadURL();
      imgUrl.add(Crypter.decrypt(photoUrl, user.password));
      //imgUrl.add(photoUrl);
    }
    return imgUrl;
  }

  getImage(String imageName) async {
    StorageReference _storage = FirebaseStorage.instance.ref();
    String photoUrl = await _storage
        .child('Users')
        .child(uid)
        .child(imageName)
        .getDownloadURL();
    return photoUrl;
  }

  deleteImage(String imageName) async {
    StorageReference _storage = FirebaseStorage.instance.ref();
    await _storage.child('Users').child(uid).child(imageName).delete();
    var userRef = db.collection('Users').document(uid);
    var doc = await userRef.get();
    var imgList = doc['Images'];
    imgList.remove(imageName);
    userRef.setData({'Images': imgList}, merge: true);
  }
}
