import 'package:alarmapp/models/alarm-model.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AlarmLayout extends StatefulWidget {
  final AlarmModel date;
  AlarmLayout(this.date);

  @override
  _AlarmLayoutState createState() => _AlarmLayoutState();
}

class _AlarmLayoutState extends State<AlarmLayout> {
  var actived;
  @override
  void initState() {
    super.initState();
    actived = widget.date.status;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(widget.date.dateTime.toString()),
        direction: DismissDirection.startToEnd,
        background: Card(
          color: Colors.white.withOpacity(0.3),
          child: Center(
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
        ),
        onDismissed: (_) {
          SharedPreferences.getInstance().then((prefs) {
            var tempDates = prefs.getStringList('alarms') ?? [];
            var tempStatus = prefs.getStringList('status') ?? [];
            var index = tempDates.indexOf(widget.date.dateTime.toString());
            tempDates.removeAt(index);
            tempStatus.removeAt(index);
            prefs.setStringList('alarms', tempDates);
            prefs.setStringList('status', tempStatus);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    widget.date.dateTime.hour <= 12 ? 'ÖÖ ' : 'ÖS',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.4),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  formatDate(widget.date.dateTime, [HH, ':', nn]),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  formatDate(widget.date.dateTime, [dd, '.', mm, '.', yyyy]),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Switch(
              onChanged: (bool val) {
                SharedPreferences.getInstance().then((prefs) {
                  var tempDates = prefs.getStringList('alarms') ?? [];
                  var tempStatus = prefs.getStringList('status') ?? [];
                  var index =
                      tempDates.indexOf(widget.date.dateTime.toString());
                  tempStatus[index] = val == true ? "true" : "false";
                  prefs.setStringList('status', tempStatus);
                  widget.date.status = val;
                  setState(() {
                    actived = widget.date.status;
                  });
                });
              },
              value: actived,
              activeColor: Color(0xff4cd963),
            )
          ],
        ));
  }
}
