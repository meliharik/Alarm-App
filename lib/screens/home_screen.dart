import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/alarm-model.dart';
import '../widgets/alarm.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _dateTime;
  List<String> alarmList;
  List<String> alarmStatus;
  var weekDays = {
    '1': "Pazartesi",
    '2': "Salı",
    '3': "Çarşamba",
    '4': "Perşembe",
    '5': "Cuma",
    '6': "Cumartesi",
    '7': "Pazar",
  };

  var monthNames = {
    '1': "Ocak",
    '2': "Şubat",
    '3': "Mart",
    '4': "Nisan",
    '5': "Mayıs",
    '6': "Haziran",
    '7': "Temmuz",
    '8': "Ağustos",
    '9': "Eylül",
    '10': "Ekim",
    '11': "Kasım",
    '12': "Aralık",
  };
  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        alarmList = prefs.getStringList('alarms') ?? [];
        alarmStatus = prefs.getStringList('status') ?? [];
      });
    });
    _dateTime = DateTime.now();
  }

  addAlarm(DateTime dateTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempList = prefs.getStringList('alarms') ?? [];
    var tempStatus = prefs.getStringList('status') ?? [];
    tempList.add(dateTime.toString());
    tempStatus.add("true");
    prefs.setStringList('alarms', tempList);
    prefs.setStringList('status', tempStatus);
    setState(() {
      alarmList = tempList;
      alarmStatus = tempStatus;
    });
  }

  clearAllAlarms() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('alarms', []);
      prefs.setStringList('status', []);
      setState(() {
        alarmList = [];
        alarmStatus = [];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                )
            ),
          ),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * (1/10),),
                Container(
                  width: MediaQuery.of(context).size.width * (9/10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Alarmların',style: TextStyle(
                        color: mainColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),),
                      Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.add,color: mainColor,size: 40,),
                            onPressed: () {
                              DatePicker.showDateTimePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(_dateTime.year + 1),
                                currentTime: DateTime.now(),
                                locale: LocaleType.tr,
                                onConfirm: (date) {
                                  addAlarm(date);
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close,color: mainColor,size: 40,),
                            onPressed: (){
                              clearAllAlarms();
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),

                Container(
                    height: MediaQuery.of(context).size.height * (2.2/10),
                    width: MediaQuery.of(context).size.width * (9/10),
                    child: alarmList != null
                        ? ListView.builder(
                      itemCount: alarmList.length,
                      itemBuilder: (context, index) {
                        return AlarmLayout(
                          AlarmModel(DateTime.parse(alarmList[index]),
                              alarmStatus[index] == "true" ? true : false),
                        );
                      },
                    )
                        : CircularProgressIndicator()),
                Spacer(),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height* ( 1.7/10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Günaydın Kerem!',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontSize: 40,
                          ),
                        ),
                        Text(
                          _dateTime.day.toString() +
                              " " +
                              monthNames[_dateTime.month.toString()],
                          style: TextStyle(
                              color: mainColor.withOpacity(0.6), fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (4/10),
                  margin: EdgeInsets.only(bottom: 0),
                  padding: EdgeInsets.only(left: 0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/image.png"),
                      )),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}



//import 'package:alarmapp/models/alarm-model.dart';
//import 'package:alarmapp/widgets/alarm.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//Color gradientFirst = Color(0xFF147482);
//Color gradientEnd = Color(0xFF64C0Ca);
//
//class HomeScreen extends StatefulWidget {
//  @override
//  _HomeScreenState createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  DateTime _dateTime;
//  List<String> alarmList;
//  List<String> alarmStatus;
//  var weekDays = {
//    '1': "Pazartesi",
//    '2': "Salı",
//    '3': "Çarşamba",
//    '4': "Perşembe",
//    '5': "Cuma",
//    '6': "Cumartesi",
//    '7': "Pazar",
//  };
//
//  var monthNames = {
//    '1': "Ocak",
//    '2': "Şubat",
//    '3': "Mart",
//    '4': "Nisan",
//    '5': "Mayıs",
//    '6': "Haziran",
//    '7': "Temmuz",
//    '8': "Ağustos",
//    '9': "Eylül",
//    '10': "Ekim",
//    '11': "Kasım",
//    '12': "Aralık",
//  };
//
//  @override
//  void initState() {
//    super.initState();
//    SharedPreferences.getInstance().then((prefs) {
//      setState(() {
//        alarmList = prefs.getStringList('alarms') ?? [];
//        alarmStatus = prefs.getStringList('status') ?? [];
//      });
//    });
//    _dateTime = DateTime.now();
//  }
//
//  addAlarm(DateTime dateTime) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    var tempList = prefs.getStringList('alarms') ?? [];
//    var tempStatus = prefs.getStringList('status') ?? [];
//    tempList.add(dateTime.toString());
//    tempStatus.add("true");
//    prefs.setStringList('alarms', tempList);
//    prefs.setStringList('status', tempStatus);
//    setState(() {
//      alarmList = tempList;
//      alarmStatus = tempStatus;
//    });
//  }
//
//  clearAllAlarms() {
//    SharedPreferences.getInstance().then((prefs) {
//      prefs.setStringList('alarms', []);
//      prefs.setStringList('status', []);
//      setState(() {
//        alarmList = [];
//        alarmStatus = [];
//      });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        body: Container(
//          child: Column(
//            children: <Widget>[
//              Container(
//                height: 10,
//                width: 100,
//                child: Row(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      'Alarmların',
//                      style: TextStyle(
//                        color: Color(
//                          0xFFFAFEFE,
//                        ),
//                        fontSize: 35,
//                        fontWeight: FontWeight.w500,
//                      ),
//                    ),
//                    Row(
//                      children: <Widget>[
//                        IconButton(
//                          icon: Icon(
//                            Icons.add,
//                            color: Color(
//                              0xFFFAFEFE,
//                            ),
//                            size: 30,
//                          ),
//                          onPressed: () {
//                            DatePicker.showDateTimePicker(
//                              context,
//                              showTitleActions: true,
//                              minTime: DateTime.now(),
//                              maxTime: DateTime(_dateTime.year + 1),
//                              currentTime: DateTime.now(),
//                              locale: LocaleType.tr,
//                              onConfirm: (date) {
//                                addAlarm(date);
//                              },
//                            );
//                          },
//                        ),
//                        IconButton(
//                          icon: Icon(
//                            Icons.close,
//                            color: Color(
//                              0xFFFAFEFE,
//                            ),
//                            size: 30,
//                          ),
//                          onPressed: () {
//                            clearAllAlarms();
//                          },
//                        ),
//                      ],
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                  height: 100,
//                  width: 100,
//                  child: alarmList != null
//                      ? ListView.builder(
//                    itemCount: alarmList.length,
//                    itemBuilder: (context, index) {
//                      return AlarmLayout(
//                        AlarmModel(DateTime.parse(alarmList[index]),
//                            alarmStatus[index] == "true" ? true : false),
//                      );
//                    },
//                  )
//                      : CircularProgressIndicator()),
//              Spacer(),
//              Center(
//                child: Container(
//                  height: 100,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Text(
//                        'Günaydın Kerem!',
//                        style: TextStyle(
//                          color: Colors.white.withOpacity(0.8),
//                          fontSize: 40,
//                        ),
//                      ),
//                      Text(
//                        _dateTime.day.toString() +
//                            " " +
//                            monthNames[_dateTime.month.toString()] +
//                            ", " +
//                            weekDays[_dateTime.day.toString()],
//                        style: TextStyle(
//                            color: Colors.white.withOpacity(0.6), fontSize: 18),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              SizedBox(
//                height: 100,
//              ),
//              Container(
//                width: 100,
//                height: 100,
//                margin: EdgeInsets.only(bottom: 0),
//                padding: EdgeInsets.only(left: 45),
//                decoration: BoxDecoration(
//                    image: DecorationImage(
//                      fit: BoxFit.cover,
//                      image: AssetImage("assets/images/image.png"),
//                    )),
//              )
//            ],
//          ),
//        ));
//  }
//}