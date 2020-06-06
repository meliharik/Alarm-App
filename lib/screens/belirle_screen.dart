import 'package:alarmapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import '../main.dart';

class Belirle extends StatefulWidget {
  @override
  _BelirleState createState() => _BelirleState();
}

class _BelirleState extends State<Belirle> {
  //Service _service;
  //UserDB _userDB;
  String _selectedAlarmPass;
  @override
  void initState() {
    //_service = Service.getInstance();
    //_userDB = UserDB.getInstance();
    super.initState();
  }

  setAlarmPass() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        prefs.setString("AlarmPass", _selectedAlarmPass);
      });
    });
  }

  setShowAlarmPass() {
    List parsedText = _selectedAlarmPass.split(":");
    String hour = "";
    String min = "";
    if (parsedText[0].length == 1) {
      hour = "0${parsedText[0]}";
    } else {
      hour = parsedText[0];
    }

    if (parsedText[1].length == 1) {
      min = "0${parsedText[1]}";
    } else {
      min = parsedText[1];
    }
    return "$hour:$min";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.fill,
            )),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * (1 / 10),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * (1 / 10),
                  width: MediaQuery.of(context).size.width * (2 / 10),
                  child: Image.asset('assets/images/belirle.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.8 / 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (8 / 10),
                  child: Text(
                    'Alarm belirle',
                    style: TextStyle(
                        fontSize: 40,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.5 / 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (8 / 10),
                  child: Text(
                    'Merhaba! Aramıza hoşgeldin.',
                    style: TextStyle(
                        fontSize: 20,
                        color: mainColor,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.4 / 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (8 / 10),
                  child: Text(
                    'Evvet, artık fotoğraflarını gizlemek için hazırız. Sonraki Ekranda belirlediğiniz alarmı kurduğunda fotoğraf depolama alanı sizi karşılayacak.',
                    style: TextStyle(
                        fontSize: 20,
                        color: mainColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.4 / 10),
                ),
                _selectedAlarmPass == null
                    ? GestureDetector(
                        onTap: showTimePicker,
                        child: Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: Text(
                            'Alarm belirlemek için bu yazıya dokun',
                            style: TextStyle(
                                fontSize: 20,
                                color: mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : Column(
                        children: <Widget>[
                          Text(
                            "Alarm Şifreniz : " + setShowAlarmPass(),
                            style: TextStyle(
                                fontSize: 30,
                                color: mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: showTimePicker,
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      (0.6 / 10),
                                  width: MediaQuery.of(context).size.width *
                                      (4 / 10),
                                  child: Center(
                                      child: Text(
                                    'Değiştir',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )),
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  //_service.addAlarmPass(_selectedAlarmPass);
                                  //await _userDB.addAlarmPassToLocal(_selectedAlarmPass);
                                  await setAlarmPass();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                      (route) => false);
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.height *
                                      (0.6 / 10),
                                  width: MediaQuery.of(context).size.width *
                                      (4 / 10),
                                  child: Center(
                                      child: Text(
                                    'Onayla',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 22),
                                  )),
                                  decoration: BoxDecoration(
                                      color: mainColor,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  showTimePicker() {
    Navigator.of(context).push(
      showPicker(
          context: context,
          value: TimeOfDay.now(),
          is24HrFormat: true,
          onChange: (time) {
            setState(() {
              _selectedAlarmPass =
                  time.hour.toString() + ":" + time.minute.toString();
            });
          },
          blurredBackground: true,
          okText: "Tamam",
          accentColor: Color(0xff093360),
          cancelText: "İptal"),
    );
    /*
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      showSecondsColumn: false,
      currentTime: DateTime.now(),
      locale: LocaleType.tr,
      onConfirm: (date) {
        setState(() {
          _selectedAlarmPass =
              date.hour.toString() + ":" + date.minute.toString();
        });
        //_service.addAlarmPass(_selectedAlarmPass);
      },
    );*/
  }
}
