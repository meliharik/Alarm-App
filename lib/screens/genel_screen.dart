import 'package:flutter/material.dart';
import '../main.dart';

class GenelScreen extends StatefulWidget {
  @override
  _GenelScreenState createState() => _GenelScreenState();
}

class _GenelScreenState extends State<GenelScreen> {
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
          ListView(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * (9/10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * (0.6/10),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Genel',style: TextStyle(
                              color: mainColor,
                              fontSize: 50,
                              fontWeight: FontWeight.bold
                          ),),
                          GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.more_horiz,
                              size: 50,
                              color: mainColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * (0.5/10),),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * (0.3/10),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * (0.3/10),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * (0.3/10),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * (1.5/10),
                                width: MediaQuery.of(context).size.width * (2.5/10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: BorderRadius.all(Radius.circular(5))
                                ),
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
