import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:alarmapp/service/service.dart';

import '../main.dart';

class Belirle extends StatefulWidget {
  @override
  _BelirleState createState() => _BelirleState();
}

class _BelirleState extends State<Belirle> {
  Service _service;
  @override
  void initState() {
    _service = Service.getInstance();
    super.initState();
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
                    'Merhaba Kerem! Aramıza hoşgeldin.',
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
                GestureDetector(
                  onTap: () {
                    DatePicker.showTimePicker(
                      context,
                      showTitleActions: true,
                      showSecondsColumn: false,
                      currentTime: DateTime.now(),
                      locale: LocaleType.tr,
                      onConfirm: (date) {
                        _service.addAlarmPass(date.hour.toString() +
                            ":" +
                            date.minute.toString());
                        //addAlarm(date);
                      },
                    );
                  },
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
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
