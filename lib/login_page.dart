import 'package:flutter/material.dart';



class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                      SizedBox(height: 40,),
                      Text('Забыли пароль?', style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 40),
                      Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 55),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.pink[900]
                        ),
                        child: Center(
                          child: Text(
                            'Войти',
                            style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
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