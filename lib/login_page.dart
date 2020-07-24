import 'package:flutter/material.dart';
import 'Widgets/CustomIcons.dart';
import 'Widgets/SocialIcons.dart';
import 'main_page.dart';


class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              Colors.pink[900],
              Colors.pink[500],
              Colors.pink[300]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('TheLearn - Учись, просто!', style: TextStyle(color: Colors.white, fontSize: 25))
                      ],
                    ),
                  ),
                  SizedBox(height: 15,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Вход в аккаунт', style: TextStyle(color: Colors.black, fontSize: 25),),
                      SizedBox(height: 60),
                      Container(
                        padding: EdgeInsets.all(20),
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
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Введите имя вашего аккаунта',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Введите пароль от вашего аккаунта',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      InkWell(
                        child: Text('Забыли пароль?', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        onTap: () {},
                      ),
                      SizedBox(height: 35),
                      InkWell(
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.purple[200],
                              Colors.purple[400],
                              Colors.purple[700]
                            ]),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(
                                color: Colors.pink.withOpacity(.3),
                                offset: Offset(0, 8),
                                blurRadius: 8
                            )],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                child: Text('Войти', style: TextStyle(color: Colors.white, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      Text('Вход через социальные сети', style: TextStyle(color: Colors.black, fontSize: 25)),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialIcon(
                            colors: [
                              Color(0xFF102397),
                              Color(0xFF187adf),
                              Color(0xFF00eaf8)
                            ],
                            iconData: CustomIcons.facebook,
                            onPressed: () {},
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFFff4f38),
                              Color(0xFFff355d),
                            ],
                            iconData: CustomIcons.googlePlus,
                            onPressed: () {},
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea),
                            ],
                            iconData: CustomIcons.twitter,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      InkWell(
                        child: Text('Регистрация', style: TextStyle(color: Colors.deepPurple,fontSize: 15)),
                        onTap: () {},
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}