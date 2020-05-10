import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  var uid;
  var name;
  var email;
  var password;
  var alarmPass;

  User(this.uid, this.name, this.email, this.password, this.alarmPass);

  User.fromSnaphot(DocumentSnapshot snapshot) {
    this.uid = snapshot.documentID;
    this.name = snapshot.data["name"];
    this.email = snapshot.data["email"];
    this.password = snapshot.data["password"];
    this.alarmPass = snapshot.data["alarmPass"];
  }
}
