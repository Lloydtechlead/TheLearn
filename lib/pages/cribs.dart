import 'package:flutter/material.dart';

class CribsPage extends StatefulWidget {

  @override
  CribsPageState createState() => CribsPageState();
}

class CribsPageState extends State<CribsPage> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - 200) / 2),
          height: 190,
          width: 210,
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('assets/crib_page_ventilator.gif', scale: 1.5),
                alignment: Alignment.topRight,
              ),
              SizedBox(width: 3),
              Container(
                height: 140,
                width: 210,
                color: Colors.black,
                child: Container(
                  margin: EdgeInsets.all(3),
                  color: Colors.grey[600],
                  child: Stack(
                    children: <Widget>[
                      Image.asset('assets/crib_page_picture.png'),
                      Container(
                        margin: EdgeInsets.only(left: 25, top: 7, bottom: 20, right: 0),
                        color: Colors.white,
                        child: Center(
                          child: Text('В будующих обновлениях!', style: TextStyle(fontFamily: 'VideoFont', fontSize: 15),),
                        ),
                      ),
                    ],
                  )
                )
              )
            ],
          )
        ),
      ],
    );
  }
}