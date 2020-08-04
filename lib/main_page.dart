import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/videolesson_page.dart';
import 'pages/tests_page.dart';
import 'pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MainPage extends StatefulWidget{

  final String userUid;

  MainPage({Key key, @required this.userUid}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userUid);
}


class _HomePageState extends State<MainPage>{
  final String userUid;
  _HomePageState(this.userUid);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      VideoLessonPage(),
      TestsPage(),
      ProfilePage(userUid: userUid),
    ];
    print(userUid);
    // TODO: implement build
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.pink,
        iconSize: 30,
        fixedColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Главная'),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              title: Text('Видеоуроки'),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Тесты'),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Профиль'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}