import 'package:flutter/material.dart';


class SignUpPage extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('Регистрация', style: TextStyle(color: Colors.white, fontSize: 30))
                      ],
                    ),
                  ),
                  SizedBox(height: 25)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}