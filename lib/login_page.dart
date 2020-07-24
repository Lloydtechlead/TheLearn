import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{

  @override
  LoginPageState createState() => LoginPageState();
}


class LoginPageState extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0, right: 12.0, top: 60.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                          "assets/books.png", alignment: Alignment.topRight, height: 50, width: 50,
                      ),
                      Text("TheLearn - Учись, просто!", style: TextStyle(fontFamily: "Poppins-Bold", fontSize: 25, fontWeight: FontWeight.bold),)
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}