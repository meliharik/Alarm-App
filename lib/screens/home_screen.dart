import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color gradientFirst = Color(0xFF147482);
Color gradientEnd = Color(0xFF64C0Ca);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  DateTime _dataTime = DateTime.now();

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
                colors: [gradientFirst,gradientEnd],
              ),
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * (1/10),
                  width: MediaQuery.of(context).size.width - 80,
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Alarmların', style: TextStyle(
                        color: Color(0xFFFAFEFE,),
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),),
                      IconButton(icon: Icon(Icons.add,color: Color(0xFFFAFEFE,),size: 30,),
                        onPressed: (){
                          showModalBottomSheet(context: context,
                              builder: (BuildContext bc){
                                return Container(
                                  height: 200,
                                  child: CupertinoDatePicker(
                                    initialDateTime: _dataTime,
                                    mode: CupertinoDatePickerMode.time,
                                    onDateTimeChanged: (dateTime){
                                      print(dateTime);
                                      setState(() {
                                        _dataTime = dateTime;
                                      });
                                    },
                                  ),
                                );
                              }
                          );
                        },),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * (2.1/10),
                  width: MediaQuery.of(context).size.width - 60,
                  child: ListView(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'ÖÖ ',style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                ),
                              ),
                              Text('08:35',style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 35,
                              ),)
                            ],
                          ),
                          Switch(
                            onChanged: (bool val){
                              val = true;
                            },
                            value: true,
                            activeColor: Color(0xff4cd963),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'ÖS ',style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                ),
                                ),
                              ),
                              Text('08:35',style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 35,
                              ),)
                            ],
                          ),
                          Switch(
                            onChanged: (bool val){
                              val = true;
                            },
                            value: false,
                            activeColor: Color(0xff4cd963),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * (0.4/10),),
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height * (1.2/10),
                    padding: EdgeInsets.only(top: 0),
                    margin: EdgeInsets.only(top: 0,bottom: 0),
                    child: Column(
                      children: <Widget>[
                        Text('Günaydın Kerem!',style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 40,
                        ),),
                        Text('4 Mayıs, Pazartesi',style: TextStyle(
                          color: Colors.white.withOpacity(0.6)
                        ),),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * (0.1/10),),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * (4.7/10),
                  margin: EdgeInsets.only(bottom: 0),
                  padding: EdgeInsets.only(left: 45),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/image.png"),
                      )
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}

