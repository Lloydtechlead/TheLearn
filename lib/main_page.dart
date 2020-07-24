import 'package:flutter/material.dart';


class MainPage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<MainPage>{

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Главная'),
            backgroundColor: Colors.pink
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              title: Text('Видеоуроки'),
              backgroundColor: Colors.pink
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Тесты'),
              backgroundColor: Colors.pink
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Профиль'),
              backgroundColor: Colors.pink
          )
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