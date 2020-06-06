import 'package:alarmapp/screens/edit_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/alarm_model.dart';
import '../widgets/alarm.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _dateTime;
  List<String> alarmList;
  List<String> alarmStatus;
  List<String> alarmDesc;
  String alarmPass;
  //UserDB userDB;
  //User user;
  String letter;
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
    getUserData();
    getAlarmList();
    getAlarmPass();
    _dateTime = DateTime.now();
    findDayPart();
  }

  getAlarmList() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        alarmList = prefs.getStringList('alarms') ?? [];
        alarmStatus = prefs.getStringList('status') ?? [];
        alarmDesc = prefs.getStringList('descs') ?? [];
      });
    });
  }

  getAlarmPass() {
    SharedPreferences.getInstance().then((prefs) {
      alarmPass = prefs.getString('AlarmPass') ?? "";
    });
  }

  getUserData() async {
    //userDB = UserDB.getInstance();
    //user = await userDB.getUserInfo();
    final directory = await getExternalStorageDirectory();
    print(directory);
  }

  addAlarm(DateTime dateTime, String desc) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempList = prefs.getStringList('alarms') ?? [];
    var tempStatus = prefs.getStringList('status') ?? [];
    var tempDesc = prefs.getStringList('descs') ?? [];
    tempList.add(dateTime.toString());
    tempStatus.add("true");
    tempDesc.add(desc);
    prefs.setStringList('alarms', tempList);
    prefs.setStringList('status', tempStatus);
    prefs.setStringList('descs', tempDesc);
    BotToast.showText(text: "Alarm Eklendi");
    setState(() {
      alarmList = tempList;
      alarmStatus = tempStatus;
      alarmDesc = tempDesc;
    });
  }

  updateAlarm(DateTime dateTime, String desc, int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var tempList = prefs.getStringList('alarms') ?? [];
    var tempDesc = prefs.getStringList('descs') ?? [];
    tempList[index] = dateTime.toString();
    tempDesc[index] = desc;
    prefs.setStringList('alarms', tempList);
    prefs.setStringList('descs', tempDesc);
    BotToast.showText(text: "Alarm Güncellendi");
    setState(() {
      alarmDesc = tempDesc;
      alarmList = tempList;
    });
  }

  findDayPart() {
    if (_dateTime.hour >= 7 && _dateTime.hour < 12) {
      letter = "Günaydın";
    } else if (_dateTime.hour >= 12 && _dateTime.hour < 18) {
      letter = "Tünaydın";
    } else if (_dateTime.hour >= 18 && _dateTime.hour < 22) {
      letter = "İyi Akşamlar";
    } else if ((_dateTime.hour >= 22 && _dateTime.hour <= 24) ||
        (_dateTime.hour >= 0 && _dateTime.hour < 7)) {
      letter = "İyi Geceler";
    }
  }

  clearAllAlarms() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setStringList('alarms', []);
      prefs.setStringList('status', []);
      prefs.setStringList('descs', []);
      BotToast.showText(text: "Tüm Alarmlar Silindi");
      setState(() {
        alarmList = [];
        alarmStatus = [];
        alarmDesc = [];
      });
    });
  }

  deleteAlarm(DateTime dateTime) async {
    SharedPreferences.getInstance().then((prefs) {
      var tempList = prefs.getStringList('alarms') ?? [];
      var tempStatus = prefs.getStringList('status') ?? [];
      var tempDesc = prefs.getStringList('descs') ?? [];
      var index = tempList.indexOf(dateTime.toString());
      tempList.removeAt(index);
      tempStatus.removeAt(index);
      tempDesc.removeAt(index);
      prefs.setStringList('alarms', tempList);
      prefs.setStringList('status', tempStatus);
      prefs.setStringList('descs', tempDesc);
      BotToast.showText(text: "Alarm Silindi");
      setState(() {
        alarmList = tempList;
        alarmStatus = tempStatus;
        alarmDesc = tempDesc;
      });
    });
  }

  addAlarmWidget() {
    _descController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 10,
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: _descController,
              autofocus: true,
              validator: (value) {
                if (value.isEmpty) {
                  return "Lütfen Açıklama Giriniz";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Açıklama',
                labelStyle: TextStyle(color: mainColor, fontSize: 20),
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: mainColor, width: 3),
                ),
              ),
            ),
          ),
          title: Text("Alarm Ekle"),
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "İPTAL",
                  style: TextStyle(color: Color(0xff093360)),
                )),
            FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    print(_descController.text);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      showPicker(
                          context: context,
                          value: TimeOfDay.now(),
                          is24HrFormat: true,
                          onChange: (time) {
                            /*
                            var timePass = time.hour.toString() + ":" + time.minute.toString();
                            if (alarmPass == timePass) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditScreen()));
                            }
                            else {                                
                              setState(() {
                                addAlarm(
                                      DateTime(0, 0, 0, time.hour, time.minute),
                                      _descController.text);
                              });
                            }
                            */
                            setState(() {
                              addAlarm(
                                  DateTime(0, 0, 0, time.hour, time.minute),
                                  _descController.text);
                            });
                          },
                          blurredBackground: true,
                          okText: "Tamam",
                          accentColor: Color(0xff093360),
                          cancelText: "İptal"),
                    );
                  }
                },
                child: Text(
                  "TAMAM",
                  style: TextStyle(color: Color(0xff093360)),
                )),
          ],
        );
      },
    );
  }

  updateAlarmWidget(int index) {
    return GestureDetector(
      onLongPress: () {
        DateTime date = DateTime.parse(alarmList[index]);
        _descController.text = alarmDesc[index];

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _descController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Lütfen Açıklama Giriniz";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Açıklama',
                    labelStyle: TextStyle(color: mainColor, fontSize: 20),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: mainColor, width: 3),
                    ),
                  ),
                ),
              ),
              title: Text("Alarm Ekle"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "İPTAL",
                      style: TextStyle(color: Color(0xff093360)),
                    )),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      deleteAlarm(date);
                    },
                    child: Text(
                      "SİL",
                      style: TextStyle(color: Color(0xff093360)),
                    )),
                FlatButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        print(_descController.text);
                        Navigator.pop(context);
                        Navigator.of(context).push(
                          showPicker(
                              context: context,
                              value: TimeOfDay(
                                  hour: date.hour, minute: date.minute),
                              is24HrFormat: true,
                              onChange: (time) {
                                setState(() {
                                  if (alarmPass ==
                                      time.hour.toString() +
                                          ":" +
                                          time.minute.toString()) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditScreen()));
                                  } else {
                                    updateAlarm(
                                        DateTime(
                                            0, 0, 0, time.hour, time.minute),
                                        _descController.text,
                                        index);
                                  }
                                });
                              },
                              blurredBackground: true,
                              okText: "Tamam",
                              accentColor: Color(0xff093360),
                              cancelText: "İptal"),
                        );
                      }
                    },
                    child: Text(
                      "TAMAM",
                      style: TextStyle(color: Color(0xff093360)),
                    )),
              ],
            );
          },
        );
      },
      child: Dismissible(
        key: Key(alarmList[index]),
        direction: DismissDirection.startToEnd,
        onDismissed: (direction) {
          DateTime date = DateTime.parse(alarmList[index]);
          var timePass = date.hour.toString() + ":" + date.minute.toString();
          if (alarmPass == timePass) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditScreen()));
            }
          setState(() {        
            deleteAlarm(DateTime.parse(alarmList[index]));
          });
        },
        child: AlarmLayout(
          AlarmModel(
            DateTime.parse(alarmList[index]),
            alarmStatus[index] == "true" ? true : false,
            alarmDesc[index],
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _descController = TextEditingController();

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
                    width: MediaQuery.of(context).size.width * (9 / 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Alarmların',
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                color: mainColor,
                                size: 40,
                              ),
                              onPressed: () {
                                addAlarmWidget();
                                /*
                                DatePicker.showDateTimePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime.now(),
                                  maxTime: DateTime(_dateTime.year + 1),
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.tr,
                                  onConfirm: (date) {
                                    /*
                                    if (user.alarmPass ==
                                        date.hour.toString() +
                                            ":" +
                                            date.minute.toString()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GenelScreen()));
                                    } else {
                                      addAlarm(date);
                                    }
                                    */
                                    if (alarmPass ==
                                        date.hour.toString() +
                                            ":" +
                                            date.minute.toString()) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditScreen()));
                                    } else {
                                      addAlarm(date);
                                    }
                                  },
                                );*/
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.close,
                                color: mainColor,
                                size: 40,
                              ),
                              onPressed: () {
                                clearAllAlarms();
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * (2.2 / 10),
                      width: MediaQuery.of(context).size.width * (9 / 10),
                      child: alarmList != null
                          ? ListView.builder(
                              itemCount: alarmList.length,
                              itemBuilder: (context, index) {
                                return updateAlarmWidget(index);
                              },
                            )
                          : CircularProgressIndicator()),
                  Spacer(),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * (1.7 / 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          /*
                          user != null
                              ? Text(
                                  '$letter ${user.name}!',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 40,
                                  ),
                                )
                              : Text(
                                  '$letter !',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 40,
                                  ),
                                ),
                                */
                          Text(
                            '$letter!',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 40,
                            ),
                          ),
                          Text(
                            _dateTime.day.toString() +
                                " " +
                                monthNames[_dateTime.month.toString()] +
                                " " +
                                weekDays[_dateTime.weekday.toString()],
                            style: TextStyle(
                                color: mainColor.withOpacity(0.6),
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * (4 / 10),
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
        ));
  }
}
