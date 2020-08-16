import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:thelearn/utilities/keys.dart';

class VideoLessonPage extends StatefulWidget{

  final List lessonsNamesRu, lessonsNamesEn;
  final String classValue;

  VideoLessonPage({Key key, @required this.lessonsNamesRu, this.lessonsNamesEn, this.classValue}) : super(key: key);

  @override
  _VideoLessonPageState createState() => _VideoLessonPageState(lessonsNamesRu, lessonsNamesEn, classValue);
}


class _VideoLessonPageState extends State<VideoLessonPage>{

  final List lessonsNamesRu, lessonsNamesEn;
  final String classValue;
  _VideoLessonPageState(this.lessonsNamesRu, this.lessonsNamesEn, this.classValue);

  bool isTheme = false;

  List themesList = [];

  String lessonName;

  Firestore firestoreInstance = Firestore.instance;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: isTheme == true ? themesList.length : lessonsNamesEn.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                changeToTheme(lessonsNamesEn[index]);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(6)
                ),
                child: Container(
                  height: 100,
                  margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 18, right: 18, top: 2, bottom: 2),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Column(
                      crossAxisAlignment: isTheme == true ? CrossAxisAlignment.center : CrossAxisAlignment.center,
                      children: <Widget>[
                        isTheme == true ?
                            Text(themesList[index]):
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          height: 50,
                          width: 150,
                          color: Colors.black,
                          child: Container(
                            height: 47,
                            width: 147,
                            color: Colors.white,
                            margin: EdgeInsets.all(5),
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
    );
  }
  void changeToTheme(nameLesson) {
    if(isTheme == false) {
      setState(() {
        isTheme = true;
        lessonName = nameLesson;
      });

      firestoreInstance.collection('video_lesson').document('class_${classValue}').collection(nameLesson).orderBy("order").getDocuments().then((value) {
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


  void videoPlayer(themeName) {
    firestoreInstance.collection('video_lesson').document('class_$classValue').collection(lessonName).document(themeName).get().then((result) {
      FlutterYoutube.playYoutubeVideoByUrl(
          apiKey: youtubeApiKey,
          videoUrl: result.data['videourl'],
          fullScreen: true,
          autoPlay: true
      );
    });
  }
}