import 'package:flutter/material.dart';

import '../main.dart';
import '../main.dart';
import '../main.dart';
import '../main.dart';

class PhotoField extends StatefulWidget {
  @override
  _PhotoFieldState createState() => _PhotoFieldState();
}

class _PhotoFieldState extends State<PhotoField> {
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
                )
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * (8/10),
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * (1/10),),
                  Container(
                    width: MediaQuery.of(context).size.width * (8/10),
                    child: Text('Fotoğraf Alanı',style: TextStyle(
                        color: mainColor,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * (0.4/10),),
                  Container(
                    width: MediaQuery.of(context).size.width * (8/10),
                    child: Text('Fotoğraflarını gizlemek için bir klasör oluşturabilir ve bu klasörleri de şifreleyebilirsin. Güvenlik her zaman önceliğimiz :)',style: TextStyle(
                        color: mainColor,
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                    ),),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * (0.5/10),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * (1.7/10),
                            width: MediaQuery.of(context).size.width * (3/10),
                            decoration: BoxDecoration(
                              image: DecorationImage(fit: BoxFit.fill,
                                image: AssetImage('assets/images/photograph_field2.png',)
                              )
                            ),
                          ),
                          Text('Genel',style: TextStyle(
                            color: mainColor.withOpacity(0.7),
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height * (1.7/10),
                            width: MediaQuery.of(context).size.width * (3/10),
                            decoration: BoxDecoration(
                                image: DecorationImage(fit: BoxFit.fill,
                                    image: AssetImage('assets/images/photograph_field1.png',)
                                )
                            ),
                          ),
                          Text('Yeni Klasör',style: TextStyle(
                              color: mainColor.withOpacity(0.7),
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
