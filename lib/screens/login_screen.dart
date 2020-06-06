import 'package:alarmapp/db/user_db.dart';
import 'package:alarmapp/models/user_model.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'package:alarmapp/service/service.dart';
import 'home_screen.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Service _service;
  UserDB _userDB;
  TextEditingController _mailController;
  TextEditingController _passwordController;
  //bool _isRemember;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _userDB = UserDB.getInstance();
    _service = Service.getInstance();
    _mailController = TextEditingController();
    _passwordController = TextEditingController();
    //_isRemember = true;
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
                        child: Image.asset('assets/images/login.png'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.6 / 10),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (8 / 10),
                        child: Text(
                          'Giriş Yap',
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
                                  borderSide:
                                      BorderSide(color: mainColor, width: 3))),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * (8 / 10),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Lütfen Şifrenizi Giriniz";
                              } else if (value.length < 6) {
                                return "Şifreniz 6 Karakterden Kısa Olamaz";
                              }
                              return null;
                            },
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.2 / 10),
                      ),
                      /*
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
                                  value: _isRemember,
                                  activeColor: mainColor,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _isRemember = value;
                                    });
                                  },
                                ),
                                Text('Beni hatırla.',
                                    style: TextStyle(
                                        color: mainColor, fontSize: 15))
                              ],
                            ),
                          ),
                        ],
                      ),
                      */
                      SizedBox(
                        height: MediaQuery.of(context).size.height * (0.2 / 10),
                      ),
                      GestureDetector(
                        onTap: login,
                        child: Container(
                          height:
                              MediaQuery.of(context).size.height * (0.8 / 10),
                          width: MediaQuery.of(context).size.width * (7.5 / 10),
                          child: Center(
                              child: Text(
                            'Giriş Yap',
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

  addtoDB(String uid) async {
    var value =
        await Firestore.instance.collection("Users").document(uid).get();
    User user = User.fromSnaphot(value);
    await _userDB.addUserToLocal(
        uid, user.name, user.email, user.password, user.alarmPass);
  }

  login() {
    if (_formKey.currentState.validate()) {
      BotToast.showLoading();
      var salt =
          "1234567890qwertyuıopğüasdfghjklşizxcvbnmöçQWERTYUIOPĞÜASDFGHJKLŞİZXCVBNMÖÇ";
      var hashedPass = Crypt.sha256(_passwordController.text, salt: salt);
      print(hashedPass.hash);
      _service.login(_mailController.text, hashedPass.hash).then((uid) async {
        if (uid != null) {
          await addtoDB(uid);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (route) => false);
          BotToast.closeAllLoading();
          BotToast.showText(
              text: "Giriş Başarılı", duration: Duration(seconds: 2));
        } else {
          BotToast.closeAllLoading();
          BotToast.showText(
              text: "E-mail Veya Şifreniz Hatalı",
              duration: Duration(seconds: 2));
        }
      });
    }
  }
}
