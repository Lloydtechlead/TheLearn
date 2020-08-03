import 'package:flutter/material.dart';
import 'Widgets/CustomIcons.dart';
import 'Widgets/SocialIcons.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/sign_up_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_page_background.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height / 3 - 35),
            Container(
              margin: EdgeInsets.only(left: size.width / 3),
              child: Text('Вход', style: TextStyle(fontFamily: 'DefaultFont', fontSize: 70)),
            ),
            SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(15),
                    height: size.height / 11,
                    width: size.width / 1.5,
                    margin: EdgeInsets.only(left: size.width / 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Введите электронный адрес',
                        hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 25)
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Container(
                    padding: EdgeInsets.all(15),
                    height: size.height / 11,
                    width: size.width / 1.5,
                    margin: EdgeInsets.only(left: size.width / 6),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Введите пароль',
                          hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 25)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 140),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: size.width / 7.5),
                  child: SocialIcon(
                    colors: [
                      Color(0xFF102397),
                      Color(0xFF187adf),
                      Color(0xFF00eaf8)
                    ],
                    iconData: CustomIcons.facebook,
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: size.width / 2.8),
                Container(
                  child: SocialIcon(
                    colors: [
                      Color(0xFF17ead9),
                      Color(0xFF6078ea),
                    ],
                    iconData: CustomIcons.twitter,
                    onPressed: () {},
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: size.width / 2.3),
              child: SocialIcon(
                colors: [
                  Color(0xFFff4f38),
                  Color(0xFFff355d),
                ],
                iconData: CustomIcons.googlePlus,
                onPressed: () {},
              ),
            ),
            Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: size.width / 2.5,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 204, 153, 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(-5, 0)
                      )]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text('Регистрация', style: TextStyle(fontFamily: 'DefaultFont',color: Colors.black, fontSize: 40)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width / 5),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: size.width / 3,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 204, 153, 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(-5, 0)
                      )]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Text('Вход', style: TextStyle(fontFamily: 'DefaultFont', color: Colors.black, fontSize: 40)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}