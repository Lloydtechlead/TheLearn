import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/videolesson_page.dart';
import 'pages/tests_page.dart';
import 'pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'pages/cribs.dart';
import 'package:connectivity/connectivity.dart';


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

  List lessonsNamesRu = [];
  List lessonsNamesEn = [];


  String nameValue;
  String surnameValue;
  String classValue;
  String imageUrl;
  Image imageProfile;

  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  List _classData = [];


  void getVideoLesson() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if(connectivityResult == ConnectivityResult.mobile) {
      getLessonNames();
    }else if(connectivityResult == ConnectivityResult.wifi) {
      getLessonNames();
    }else {
      showAlert();
    }
  }

  @override
  void initState() {
    super.initState();
    getVideoLesson();
    getUserInfo();
  }


  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      VideoLessonPage(lessonsNamesRu: lessonsNamesRu, lessonsNamesEn: lessonsNamesEn, classValue: classValue, userUid: userUid),
      TestsPage(),
      CribsPage(),
      ProfilePage(nameValue: nameValue, surnameValue: surnameValue, classValue: classValue, imageProfile: imageProfile, userUid: userUid),
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
            title: Text('Главная', style: TextStyle(fontSize: 13)),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.videocam),
              title: Text('Видеоуроки', style: TextStyle(fontSize: 13)),
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              title: Text('Тесты', style: TextStyle(fontSize: 13)),
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Шпаргалки', style: TextStyle(fontSize: 13))
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Профиль', style: TextStyle(fontSize: 13)),
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

  void getLessonNames() {
    firestoreInstance.collection('users').document(userUid).get().then((result) {
      firestoreInstance.collection('video_lesson').document('class_${result.data['class']}').get().then((value) {
        setState(() {
          _classData = value.data.values.toList();
          for(var i = 0; i < _classData.length; i++) {
            lessonsNamesEn.add(_classData[i]);
            if(_classData[i] == 'mathematics') {
              lessonsNamesRu.add('Математика');
            }else if(_classData[i] == 'russian_language') {
              lessonsNamesRu.add('Русский язык');
            }else if(_classData[i] == 'literature') {
              lessonsNamesRu.add('Литература');
            }else if(_classData[i] == 'surrounding_world') {
              lessonsNamesRu.add('Окружающий мир');
            }else if(_classData[i] == 'english_language') {
              lessonsNamesRu.add('Английский язык');
            }else if(_classData[i] == 'biology') {
              lessonsNamesRu.add('Биология');
            }else if(_classData[i] == 'geography') {
              lessonsNamesRu.add('География');
            }else if(_classData[i] == 'social studies') {
              lessonsNamesRu.add('Обществознание');
            }else if(_classData[i] == 'informatics') {
              lessonsNamesRu.add('Информатика');
            }else if(_classData[i] == 'algebra') {
              lessonsNamesRu.add('Алгебра');
            }else if(_classData[i] == 'geometry') {
              lessonsNamesRu.add('Геометрия');
            }else if(_classData[i] == 'physics') {
              lessonsNamesRu.add('Физика');
            }else if(_classData[i] == 'general history') {
              lessonsNamesRu.add('Всеобщая история');
            }else if(_classData[i] == 'history of Russia') {
              lessonsNamesRu.add('История России');
            }else if(_classData[i] == 'chemistry') {
              lessonsNamesRu.add('Химия');
            }else if(_classData[i] == 'life safety') {
              lessonsNamesRu.add('ОБЖ');
            }
          }
        });
      });
    });
  }

  void getUserInfo() {
    firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        nameValue = value.data['name'];
        surnameValue = value.data['surname'];
        classValue = value.data['class'];
        imageProfile = Image.network(value.data['photourl']);
      });
    });
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) {
          print(message);
        },
        onResume: (Map<String, dynamic> message) {
          print(message);
        },
        onLaunch: (Map<String, dynamic> message) {
          print(message);
        }
    );
  }

  Future<void> showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: <Widget>[
              Icon(Icons.error),
              Text('Ошибка подключения')
            ],
          ),
          content: SingleChildScrollView(
            child: Text('Пожалуйста, проверьте подключение к интернету'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Row(
                children: <Widget>[
                  Text('Повторить'),
                  Icon(Icons.refresh)
                ],
              ),
              onPressed: () {
                getVideoLesson();
                getUserInfo();
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Row(
                children: <Widget>[
                  Text('Ок'),
                  Icon(Icons.check_circle)
                ],
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }
}