import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'crib_page.dart';

class CribsPage extends StatefulWidget {

  final String userUid;

  CribsPage({Key key, @required this.userUid}) : super(key: key);

  @override
  CribsPageState createState() => CribsPageState(userUid);
}

class CribsPageState extends State<CribsPage> {

  final String userUid;

  CribsPageState(this.userUid);

  String classValue;

  Firestore firestoreInstance = Firestore.instance;

  List cribsListEn = [];
  List cribsList = [];
  List cribsThemesList = [];

  bool isCribsThemes = false;

  String cribName;
  
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          isCribsThemes = false;
          cribsThemesList = [];
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                reverse: true,
                itemCount: isCribsThemes == true ? cribsThemesList.length : cribsList.length,
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if(isCribsThemes == false) {
                        getCribsThemes(index);
                      } else if(isCribsThemes == true) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CribPage(cribName: cribName, cribThemeName: cribsThemesList[index])));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [BoxShadow(
                              color: Colors.black,
                              blurRadius: 7
                          )]
                      ),
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Container(
                          margin: EdgeInsets.only(left: 14, right: 14, top: 2, bottom: 2),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Column(
                            crossAxisAlignment:  CrossAxisAlignment.center,
                            children: <Widget>[
                              isCribsThemes == true ? Text(cribsThemesList[index]) : Text(cribsList[index])
                            ],
                          ),
                        ),
                      ),
                    )
                )
            ),
          ),
          Image.asset('assets/videolesson_picture_1.png'),
        ],
      ),
    );
  }
  
  void getCribs() {
    firestoreInstance.collection('cribs').document('class_$classValue').snapshots().listen((event) {
      print(event.data);
      event.data.forEach((key, value) {
        setState(() {
          cribsListEn.add(value);
          if(value == 'mathematics') {
            cribsList.add('Математика');
          }else if(value == 'russian_language') {
            cribsList.add('Русский язык');
          }else if(value == 'literature') {
            cribsList.add('Литература');
          }else if(value == 'surrounding_world') {
            cribsList.add('Окружающий мир');
          }else if(value == 'english_language') {
            cribsList.add('Английский язык');
          }else if(value == 'biology') {
            cribsList.add('Биология');
          }else if(value == 'geography') {
            cribsList.add('География');
          }else if(value == 'social studies') {
            cribsList.add('Обществознание');
          }else if(value == 'informatics') {
            cribsList.add('Информатика');
          }else if(value == 'algebra') {
            cribsList.add('Алгебра');
          }else if(value == 'geometry') {
            cribsList.add('Геометрия');
          }else if(value == 'physics') {
            cribsList.add('Физика');
          }else if(value == 'general history') {
            cribsList.add('Всеобщая история');
          }else if(value == 'history of Russia') {
            cribsList.add('История России');
          }else if(value == 'chemistry') {
            cribsList.add('Химия');
          }else if(value == 'life safety') {
            cribsList.add('ОБЖ');
          }
        });
      });
    });
  }


  void getUserInfo() async {
    await firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        classValue = value.data['class'];
      });
    }).then((_) async {
      getCribs();
    });
  }

  void getCribsThemes(index) {

    firestoreInstance.collection('cribs').document('class_$classValue').collection(cribsListEn[index]).snapshots().listen((event) {
      event.documents.forEach((element) {
        cribsThemesList.add(element.documentID);
      });
      setState(() {
        isCribsThemes = true;
        cribName = cribsListEn[index];
      });
    });
  }
}