import 'package:flutter/material.dart';
import '../main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                child: Column(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * (1/10),),
                    Container(
                      height: MediaQuery.of(context).size.height * (1/10),
                      width: MediaQuery.of(context).size.width * (2/10),
                      child: Image.asset('assets/images/register.png'),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * (0.6/10),),
                    Container(
                      width: MediaQuery.of(context).size.width * (8/10),
                      child: Text('Kayıt Ol',style: TextStyle(
                          fontSize: 40,
                          color: mainColor,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),

                    Container(
                        width: MediaQuery.of(context).size.width * (8/10),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'E Posta',
                              labelStyle: TextStyle(
                                  color: mainColor,
                                  fontSize: 20
                              ),
                              hintText: 'ornek@gmail.com',
                              hintStyle: TextStyle(color: Colors.grey,),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor,width: 3)
                              )
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width * (8/10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Şifre',
                              labelStyle: TextStyle(
                                  color: mainColor,
                                  fontSize: 20
                              ),
                              hintText: '**********',
                              hintStyle: TextStyle(color: Colors.grey,),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor,width: 3)
                              )
                          ),
                        )
                    ),
                    SizedBox(height: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width * (8/10),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Şifreni onayla',
                              labelStyle: TextStyle(
                                  color: mainColor,
                                  fontSize: 20
                              ),
                              hintText: '**********',
                              hintStyle: TextStyle(color: Colors.grey,),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: mainColor,width: 3)
                              )
                          ),
                        )
                    ),

                    SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (0.5/10),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: true,
                                activeColor: mainColor,
                                onChanged: (bool value){
                                  setState(() {
                                    value = false;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: 'Kullanım koşullarını',style: TextStyle(fontWeight:FontWeight.bold,decoration: TextDecoration.underline,color: mainColor,fontSize: 15)),
                                      TextSpan(text: ' okudum ve kabul\nediyorum.',style: TextStyle(color: mainColor,fontSize: 15))
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width * (0.5/10),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: false,
                                activeColor: mainColor,
                                onChanged: (bool value){
                                  setState(() {
                                    value = false;
                                  });
                                },
                              ),
                              RichText(
                                text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(text: 'Kişisel verilerimin işlenmesini',style: TextStyle(fontWeight:FontWeight.bold,decoration: TextDecoration.underline,color: mainColor,fontSize: 15)),
                                      TextSpan(text: ' kabul\nediyorum.',style: TextStyle(color: mainColor,fontSize: 15))
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * (0.2/10),),
                    GestureDetector(
                      onTap: (){},
                      child: Container(
                        height: MediaQuery.of(context).size.height * (0.8/10),
                        width: MediaQuery.of(context).size.width * (7.5/10),
                        child: Center(child: Text('Kayıt Ol',style: TextStyle(color: Colors.white,fontSize: 22),)),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.all(Radius.circular(30))
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
