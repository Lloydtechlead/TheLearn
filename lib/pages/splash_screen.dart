import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:thelearn/main_page.dart';
import 'package:thelearn/login_page.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {

  @override
  SplashScreenState createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen> {

  String userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mockCheckForSession().then((value) {
      checkUserSettings();
    });
  }

  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});

    return true;
  }

  void checkUserSettings() async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/settings.txt');
      userData = await file.readAsString();
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userUid: userData)));
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/app_icon.jpg', scale: 2),
          Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Colors.redAccent,
            highlightColor: Colors.deepPurple,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Text('TheLearn - Учись, просто!', style: TextStyle(
                  fontFamily: 'VideoFont',
                  fontSize: 30,
                  shadows: <Shadow>[
                    Shadow(
                      blurRadius: 18,
                      color: Colors.black,
                      offset: Offset.fromDirection(120, 12)
                    )
                  ]
              )),
            ),
          )
        ],
      )
    );
  }
}