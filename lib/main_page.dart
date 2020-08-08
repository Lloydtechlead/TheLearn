import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/videolesson_page.dart';
import 'pages/tests_page.dart';
import 'pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

  Firestore firestoreInstance = Firestore.instance;

  List lessonsNames = [];

  String nameValue;
  String surnameValue;
  String classValue;
  String imageUrl;
  Image imageProfile;


  void getVideoLesson() {

    List _classData = [];

    firestoreInstance.collection('video_lesson').document('class_2').get().then((value) {
      setState(() {
        _classData = value.data.values.toList();
        for(var i = 0; i < _classData.length; i++) {
          if(_classData[i] == 'mathematics') {
            lessonsNames.add('Матемитика');
          }else if(_classData[i] == 'russian_language') {
            lessonsNames.add('Русский язык');
          }else if(_classData[i] == 'literature') {
            lessonsNames.add('Литература');
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getVideoLesson();
    firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        nameValue = value.data['name'];
        surnameValue = value.data['surname'];
        classValue = value.data['class'];
        imageProfile = Image.network(value.data['photourl']);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      VideoLessonPage(lessonsNames: lessonsNames),
      TestsPage(),
      ProfilePage(nameValue: nameValue, surnameValue: surnameValue, classValue: classValue, imageProfile: imageProfile),
    ];
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