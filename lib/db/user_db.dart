import 'package:alarmapp/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDB {
  static UserDB _localDB;

  UserDB._();

  static getInstance() {
    if (_localDB == null) {
      _localDB = UserDB._();
    }
    return _localDB;
  }

  addUserToLocal(String uid, name, mail, password, alarmPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("uid", uid);
    prefs.setString("name", name);
    prefs.setString("mail", mail);
    prefs.setString("password", password);
    prefs.setString("alarmPass", alarmPass);
  }

  addAlarmPassToLocal(String alarmPass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("alarmPass", alarmPass);
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid") ?? '';
    String name = prefs.getString("name") ?? '';
    String mail = prefs.getString("mail") ?? '';
    String password = prefs.getString("password") ?? '';
    String alarmPass = prefs.getString("alarmPass") ?? '';
    User user = new User(uid, name, mail, password, alarmPass);
    return user;
  }

  getUID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString("uid") ?? '';
    return uid;
  }
}
