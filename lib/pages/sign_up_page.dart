import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thelearn/login_page.dart';


class SignUpPage extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerRight,
            image: AssetImage('assets/registration_picture.png'),
            fit: BoxFit.contain
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.transparent),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.only(left: 15),
              height: 70,
              width: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Имя'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 55),
              height: 70,
              width: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Фамилия'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 15),
              height: 70,
              width: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Электронная почта'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 55),
              height: 70,
              width: 140,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Пароль'
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
