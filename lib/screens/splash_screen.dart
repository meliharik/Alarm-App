import 'package:alarmapp/screens/home_screen.dart';
import 'package:alarmapp/screens/ready_screen.dart';
import 'package:alarmapp/service/file_operations.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //UserDB userDB;
  //Service service;
  PermissionHandler _permissionHandler;
  FileOperations fileOperations;
  @override
  void initState() {
    super.initState();
    //userDB = UserDB.getInstance();
    //service = Service.getInstance();
    fileOperations = FileOperations.getInstance();
    _permissionHandler = PermissionHandler();
    requestAllPermissions();
    Future.delayed(const Duration(milliseconds: 1000), () async {
      programInfo();
    });
  }

  requestAllPermissions() async {
    await _requestPermission(PermissionGroup.storage);
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    var result = await _permissionHandler.requestPermissions([permission]);
    if (result[permission] == PermissionStatus.granted) {
      return true;
    }
    return false;
  }

  programInfo() async {
    SharedPreferences.getInstance().then((prefs) {
      bool isFirst = prefs.getBool("isFirst") ?? true;
      if (isFirst) {
        prefs.setBool("isFirst", false);
        Navigator.pushReplacement(context,
            new MaterialPageRoute(builder: (context) => ReadyScreen()));
      } else {
        Navigator.pushReplacement(
            context, new MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  /*
  userInfo() async {
    User user = await userDB.getUserInfo();
    if (user.uid != "") {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => HelloScreen()));
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromRGBO(240, 240, 240, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "ALARM APP",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
