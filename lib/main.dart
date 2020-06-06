import 'package:alarmapp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

Color mainColor = Color(0xff093360);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Alarm App',
      home: SplashScreen(),
    );
  }
}
