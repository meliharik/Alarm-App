import 'package:alarmapp/screens/belirle_screen.dart';
import 'package:alarmapp/screens/genel_screen.dart';
import 'package:alarmapp/screens/hello_screen.dart';
import 'package:alarmapp/screens/home_screen.dart';
import 'package:alarmapp/screens/login_screen.dart';
import 'package:alarmapp/screens/photo_field.dart';
import 'package:alarmapp/screens/ready_screen.dart';
import 'package:alarmapp/screens/register_screen.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

Color mainColor = Color(0xff093360);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm App',
      home: Login(),
    );
  }
}
