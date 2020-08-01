import 'package:flutter/material.dart';


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/home_page_progressbar.png', scale: 2.5),
            )
          ],
        ),
      ),
    );
  }
}