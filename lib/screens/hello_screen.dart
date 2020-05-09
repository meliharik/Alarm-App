import 'package:alarmapp/screens/register_screen.dart';
import 'package:flutter/material.dart';

class HelloScreen extends StatefulWidget {
  @override
  _HelloScreenState createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
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
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * (2.3/10),),
                  Container(
                      height: MediaQuery.of(context).size.height * (2/10),
                      width: MediaQuery.of(context).size.width * (4/10),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/hand.png'),
                            fit: BoxFit.fill,
                          )
                      ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * (0.7/10),),
                  Text('Merhaba',style: TextStyle(
                    color: Color(0xff093360),
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
                  Text("App'e hoşgeldin!\nKullanmaya başlamak için kayıt ol\nveya giriş yap.",textAlign:TextAlign.center,style: TextStyle(
                    color: Color(0xff093360),
                    fontSize: 20
                  ),),
                  SizedBox(height: MediaQuery.of(context).size.height * (0.7/10),),
                  Container(
                    width: MediaQuery.of(context).size.width * (7/10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text('Giriş Yap',style: TextStyle(
                          color: Color(0xff093360),
                          fontSize: 20
                        ),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
                          },
                          child: Container(
                            child: Center(
                              child: Text('Kayıt Ol',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                              ),),
                            ),
                            height: MediaQuery.of(context).size.height * (0.6/10),
                            width: MediaQuery.of(context).size.width * (3/10),
                            decoration: BoxDecoration(
                                color: Color(0xff093360),
                                borderRadius: BorderRadius.all(Radius.circular(25))
                            ),
                          ),
                        )

                      ],
                    ),
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
