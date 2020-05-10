
import 'package:alarmapp/screens/hello_screen.dart';
import 'package:flutter/material.dart';
import 'screens/hello_screen.dart';
import 'package:bot_toast/bot_toast.dart';

Color mainColor = Color(0xff093360);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
      debugShowCheckedModeBanner: false,
      title: 'Alarm App',
      home: HelloScreen(),
    );
  }
}
