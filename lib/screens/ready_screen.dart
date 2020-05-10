import 'package:alarmapp/db/user_db.dart';
import 'package:alarmapp/models/user_model.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'belirle_screen.dart';

class ReadyScreen extends StatefulWidget {
  @override
  _ReadyScreenState createState() => _ReadyScreenState();
}

class _ReadyScreenState extends State<ReadyScreen> {
  UserDB _userDB;
  @override
  void initState() {
    _userDB = UserDB.getInstance();
    User user = _userDB.getUserInfo();
    print(user.toString());
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
                  child: Image.asset('assets/images/ready.png'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.8 / 10),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (8 / 10),
                  child: Text(
                    'Artık hazırız!',
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
                    'Evvet, artık fotoğraflarını gizlemek için hazırız. Sonraki Ekranda belirlediğiniz alarmı kurduğunda fotoğraf depolama alanı sizi karşılayacak.',
                    style: TextStyle(
                        fontSize: 20,
                        color: mainColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.5 / 10),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Belirle()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * (0.8 / 10),
                    width: MediaQuery.of(context).size.width * (7.5 / 10),
                    child: Center(
                        child: Text(
                      'Başlayalım',
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )),
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
