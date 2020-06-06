import 'package:alarmapp/db/user_db.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alarmapp/service/service.dart';
import 'ready_screen.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Service _service;
  UserDB _userDB;
  TextEditingController _mailController;
  TextEditingController _passwordController;
  TextEditingController _validatePasswordController;
  TextEditingController _nameController;
  bool _usingConditions;
  bool _personelData;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _service = Service.getInstance();
    _userDB = UserDB.getInstance();
    _mailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _validatePasswordController = new TextEditingController();
    _nameController = new TextEditingController();
    _usingConditions = true;
    _personelData = true;
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
          ListView(
            children: <Widget>[
              Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (1 / 10),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * (1 / 10),
                        width: MediaQuery.of(context).size.width * (2 / 10),
                        child: Image.asset('assets/images/register.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.6 / 10),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (8 / 10),
                        child: Text(
                          'Kayıt Ol',
                          style: TextStyle(
                              fontSize: 40,
                              color: mainColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.2 / 10),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: TextFormField(
                            controller: _nameController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "İsim Soyisim giriniz";
                              } else if (value.length < 5) {
                                return "İsim Soyisim En Az 5 Karakter Olmalı";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'İsim Soyisim',
                                labelStyle:
                                    TextStyle(color: mainColor, fontSize: 20),
                                //hintText: 'İsim Soyisim',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 3))),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: TextFormField(
                            controller: _mailController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Mail Adresinizi Giriniz';
                              } else if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return "Mail Adresinizi Formata Uygun Değil";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'E Posta',
                                labelStyle:
                                    TextStyle(color: mainColor, fontSize: 20),
                                hintText: 'ornek@gmail.com',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 3))),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: TextFormField(
                            controller: _passwordController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Lütfen Şifrenizi Giriniz";
                              } else if (value.length < 6) {
                                return "Şifreniz 6 Karakterden Kısa Olamaz";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Şifre',
                                labelStyle:
                                    TextStyle(color: mainColor, fontSize: 20),
                                hintText: '**********',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 3))),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: TextFormField(
                            controller: _validatePasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Lütfen Şifrenizi Tekrar Giriniz";
                              } else if (value != _passwordController.text) {
                                return "Girdiğiniz Şifreler Uyuşmuyor";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: 'Şifreni onayla',
                                labelStyle:
                                    TextStyle(color: mainColor, fontSize: 20),
                                hintText: '**********',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: mainColor, width: 3))),
                          )),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.2 / 10),
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (0.5 / 10),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _usingConditions,
                                  activeColor: mainColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _usingConditions = value;
                                    });
                                  },
                                ),
                                RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Kullanım koşullarını',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: mainColor,
                                            fontSize: 15)),
                                    TextSpan(
                                        text: ' okudum ve kabul\nediyorum.',
                                        style: TextStyle(
                                            color: mainColor, fontSize: 15))
                                  ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width:
                                MediaQuery.of(context).size.width * (0.5 / 10),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                  value: _personelData,
                                  activeColor: mainColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _personelData = value;
                                    });
                                  },
                                ),
                                RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text: 'Kişisel verilerimin işlenmesini',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline,
                                            color: mainColor,
                                            fontSize: 15)),
                                    TextSpan(
                                        text: ' kabul\nediyorum.',
                                        style: TextStyle(
                                            color: mainColor, fontSize: 15))
                                  ]),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.2 / 10),
                      ),
                      GestureDetector(
                        onTap: () {
                          signUp();
                        },
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * (0.8 / 10),
                          width: MediaQuery.of(context).size.width * (7.5 / 10),
                          child: Center(
                              child: Text(
                            'Kayıt Ol',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          )),
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  signUp() {
    if (_formKey.currentState.validate()) {
      if (_usingConditions && _personelData) {
        BotToast.showLoading();
        var salt =
            "1234567890qwertyuıopğüasdfghjklşizxcvbnmöçQWERTYUIOPĞÜASDFGHJKLŞİZXCVBNMÖÇ";
        var hashedPass = Crypt.sha256(_passwordController.text, salt: salt);
        _service.register(_mailController.text, hashedPass.hash).then((uid) {
          if (uid != null) {
            _service.addUserDB(
                _nameController.text, _mailController.text, hashedPass.hash);
            _userDB.addUserToLocal(uid, _nameController.text,
                _mailController.text, hashedPass.hash, "");
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ReadyScreen()));
            BotToast.closeAllLoading();
            BotToast.showText(
                text: "Kayıt Başarılı", duration: Duration(seconds: 2));
          } else {
            BotToast.closeAllLoading();
            BotToast.showText(
                text: "Kayıt Başarısız", duration: Duration(seconds: 2));
            print('Sorun oluştu.');
          }
        });
      } else if (!_usingConditions && !_personelData) {
        BotToast.showText(
            text:
                "Kullanım Koşullarını ve Kişisel Verilerilerin İşlenmesini Kabul Etmediniz",
            duration: Duration(seconds: 2));
      } else if (!_usingConditions) {
        BotToast.showText(
            text: "Kullanım Koşullarını Kabul Etmediniz",
            duration: Duration(seconds: 2));
      } else if (!_personelData) {
        BotToast.showText(
            text: "Kişisel Verilerilerin İşlenmesini Kabul Etmediniz",
            duration: Duration(seconds: 2));
      }
    }
  }
}
