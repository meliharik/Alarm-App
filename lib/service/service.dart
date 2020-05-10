import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Service {
  static Service _service;
  var db;
  static String uid;
  Service._() {
    db = Firestore.instance;
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
    };
    db.collection('Users').document(uid).setData(data);
  }

  addAlarmPass(alarmPass) async {
    db
        .collection('Users')
        .document(uid)
        .setData({'alarmPass': alarmPass}, merge: true);
  }
}
