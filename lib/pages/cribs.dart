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
          height: 170,
          width: 200,
          child: Column(
            children: <Widget>[
              Container(
                child: Image.asset('assets/crib_page_ventilator.gif', scale: 1.5),
                alignment: Alignment.topRight,
              ),
              Container(
                height: 120,
                width: 200,
                color: Colors.black,
                child: Container(
                  margin: EdgeInsets.all(3),
                  color: Colors.grey[600],
                  child: Container(
                    margin: EdgeInsets.only(left: 14, top: 7, bottom: 7, right: 7),
                    color: Colors.white,
                    child: Center(
                      child: Text('В будующих обновлениях!', style: TextStyle(fontFamily: 'VideoFont', fontSize: 15),),
                    ),
                  ),
                )
              )
            ],
          )
        ),
      ],
    );
  }
}