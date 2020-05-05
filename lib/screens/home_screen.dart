import 'package:alarmapp/models/alarm-model.dart';
import 'package:alarmapp/widgets/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color gradientFirst = Color(0xFF147482);
Color gradientEnd = Color(0xFF64C0Ca);

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
        body: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [gradientFirst, gradientEnd],
            ),
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * (2 / 10),
                  padding: EdgeInsets.only(top: 30),
                  margin: EdgeInsets.only(top: 0, bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Günaydın Kerem!',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 40,
                        ),
                      ),
                      Text(
                        _dateTime.day.toString() +
                            " " +
                            monthNames[_dateTime.month.toString()] +
                            ", " +
                            weekDays[_dateTime.day.toString()],
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.6), fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * (1 / 10),
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.only(top: 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Alarmların',
                      style: TextStyle(
                        color: Color(
                          0xFFFAFEFE,
                        ),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: Color(
                              0xFFFAFEFE,
                            ),
                            size: 30,
                          ),
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
                          icon: Icon(
                            Icons.close,
                            color: Color(
                              0xFFFAFEFE,
                            ),
                            size: 30,
                          ),
                          onPressed: () {
                            clearAllAlarms();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                  height: MediaQuery.of(context).size.height * (2.1 / 10),
                  width: MediaQuery.of(context).size.width - 30,
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
              SizedBox(
                height: MediaQuery.of(context).size.height * (0.1 / 10),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * (4.7 / 10),
                margin: EdgeInsets.only(bottom: 0),
                padding: EdgeInsets.only(left: 45),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/image.png"),
                )),
              )
            ],
          ),
        )
      ],
    ));
  }
}