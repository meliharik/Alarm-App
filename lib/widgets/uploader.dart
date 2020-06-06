import 'package:alarmapp/db/user_db.dart';
import 'package:alarmapp/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypter/crypter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Uploader extends StatefulWidget {
  final String uid;
  final List<dynamic> imageList;

  Uploader(this.uid, this.imageList);
  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  StorageReference _storage = FirebaseStorage.instance.ref();
  StorageUploadTask _uploadTask;
  Firestore cloudDB = Firestore.instance;
  User user;
  UserDB userDB = UserDB.getInstance();

  _startUpload() async {
    for (var image in widget.imageList) {
      dynamic byteData =
          await image.getByteData(quality: 50); //Set quality by photo size
      //dynamic byteData = await image.getThumbByteData(500, 500); //For thumnailPhotos
      var uintData = byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
      var encrypted = Crypter.encrypt(uintData, user.password);
      setState(() {
        _uploadTask = _storage
            .child('Users')
            .child(widget.uid)
            .child(image.name)
            .putData(encrypted);
      });
      _uploadTask.events.listen((event) async {
        if (event.type == StorageTaskEventType.success) {
          await addImgNameToDB(image.name);
          //Navigator.pop(context);
        }
      });
    }
  }

  addImgNameToDB(String imageName) async {
    var userRef = cloudDB.collection('Users').document(widget.uid);
    var doc = await userRef.get();
    var imgList = doc['Images'];
    imgList.add(imageName);
    userRef.setData({'Images': imgList}, merge: true);
  }

  getUserData() async {
    user = await userDB.getUserInfo();
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    _startUpload();
  }

  @override
  Widget build(BuildContext context) {
    return _uploadTask != null
        ? StreamBuilder<StorageTaskEvent>(
            stream: _uploadTask.events,
            builder: (_, snapshot) {
              var event = snapshot?.data?.snapshot;

              double progressPercent = event != null
                  ? event.bytesTransferred / event.totalByteCount
                  : 0;

              return Center(
                child: Container(
                  height: 300,
                  width: 250,
                  child: Card(
                    elevation: 10,
                    color: Colors.white,
                    child: CircularPercentIndicator(
                      radius: 200.0,
                      lineWidth: 10.0,
                      percent: progressPercent,
                      header: _uploadTask.isComplete
                          ? Text(
                              "Fotoğraflar Yüklendi",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            )
                          : Text(
                              "Fotoğraflar Yükleniyor",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                      footer: _uploadTask.isComplete
                          ? FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Kapat",
                                style: TextStyle(fontSize: 18),
                              ))
                          : FlatButton(
                              onPressed: () {
                                _uploadTask.cancel();
                                Navigator.pop(context);
                              },
                              child: Text(
                                "İptal Et",
                                style: TextStyle(fontSize: 18),
                              )),
                      center: Text(
                        '%${(progressPercent * 100).toInt()}',
                        style: TextStyle(fontSize: 25),
                      ),
                      progressColor: Colors.green,
                    ),
                  ),
                ),
              );
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
