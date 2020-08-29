import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:thelearn/utilities/keys.dart';
import 'theme_page.dart';

class VideoLessonPage extends StatefulWidget{

  final List lessonsNamesRu, lessonsNamesEn;
  final String classValue, userUid;

  VideoLessonPage({Key key, @required this.lessonsNamesRu, this.lessonsNamesEn, this.classValue, this.userUid}) : super(key: key);

  @override
  _VideoLessonPageState createState() => _VideoLessonPageState(lessonsNamesRu, lessonsNamesEn, classValue, userUid);
}


class _VideoLessonPageState extends State<VideoLessonPage>{

  final List lessonsNamesRu, lessonsNamesEn;
  final String classValue, userUid;
  _VideoLessonPageState(this.lessonsNamesRu, this.lessonsNamesEn, this.classValue, this.userUid);

  bool isTheme = false;

  List themesList = [];

  String lessonName;

  Firestore firestoreInstance = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () {
          if(isTheme == true) {
            changeToTheme(null);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  reverse: true,
                  itemCount: isTheme == true ? themesList.length : lessonsNamesEn.length,
                  itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        setState(() {
                          if(isTheme == true) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ThemePage(lessonName: lessonName, themeName: themesList[index], classValue: classValue, userUid: userUid)));
                          }else {
                            changeToTheme(lessonsNamesEn[index]);
                          }
                        });
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
                              crossAxisAlignment: isTheme == true ? CrossAxisAlignment.center : CrossAxisAlignment.end,
                              children: <Widget>[
                                isTheme == true ?
                                Text(themesList[index]):
                                Container(
                                  margin: EdgeInsets.only(top: 30),
                                  height: 50,
                                  width: 150,
                                  color: Colors.black,
                                  child: Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.all(3),
                                    child: Center(
                                      child: Text(lessonsNamesRu[index], style: TextStyle(fontFamily: 'VideoFont', fontSize: 20),),
                                    ),
                                  ),
                                )
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
        )
    );
  }
  void changeToTheme(nameLesson) {
    if(isTheme == false) {
      setState(() {
        isTheme = true;
        lessonName = nameLesson;
      });

      firestoreInstance.collection('video_lesson').document('class_$classValue').collection(nameLesson).orderBy("order").getDocuments().then((value) {
        value.documents.forEach((element) {
          setState(() {
            themesList.add(element.documentID);
          });
        });
      });

    }else if(isTheme == true) {
      setState(() {
        isTheme = false;
        themesList = [];
        lessonName = null;
      });
    }
  }
}