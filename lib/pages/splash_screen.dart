import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:thelearn/main_page.dart';
import 'package:thelearn/login_page.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SplashScreen extends StatefulWidget {

  @override
  SplashScreenState createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen> {

  Firestore firestoreInstance = Firestore.instance;

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
      firestoreInstance.collection('users').document(userData).get().then((value) {
          if(value.data == null) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
          }else {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userUid: userData)));
          }
        });
    } catch (e) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/splash_icon.png', scale: 2),
          Shimmer.fromColors(
            period: Duration(milliseconds: 1500),
            baseColor: Colors.redAccent,
            highlightColor: Colors.deepPurple,
            child: Container(
              alignment: Alignment.center,
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