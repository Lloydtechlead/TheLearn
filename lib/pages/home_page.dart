import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topLeft,
            image: ExactAssetImage("assets/home_page_progressbar.png", scale: 2.3)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: size.height / 1.7,),
            Container(
              height: size.height / 12,
              width: size.width / 1.7,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .2),
                      blurRadius: 10,
                  )]
              ),
              child: Center(
                child: Text('Новые видео', style: TextStyle(fontFamily: 'DefaultFont', fontSize: 40)),
              ),
            ),
            Container(
              height: size.height / 4.5,
              margin: EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Color.fromRGBO(123, 104, 238, .2),
                    blurRadius: 10,
                    offset: Offset(0, 10)
                  )]
              ),
            )
          ],
        ),
      ),
    );
  }
}