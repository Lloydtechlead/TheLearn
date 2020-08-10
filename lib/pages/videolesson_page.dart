import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VideoLessonPage extends StatefulWidget{

  final List lessonsNamesRu, lessonsNamesEn;

  VideoLessonPage({Key key, @required this.lessonsNamesRu, this.lessonsNamesEn}) : super(key: key);

  @override
  _VideoLessonPageState createState() => _VideoLessonPageState(lessonsNamesRu, lessonsNamesEn);
}


class _VideoLessonPageState extends State<VideoLessonPage>{

  final List lessonsNamesRu, lessonsNamesEn;
  _VideoLessonPageState(this.lessonsNamesRu, this.lessonsNamesEn);

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  bool isTheme = false;

  List themesList = [];

  Firestore firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemBuilder: (context, index) => Container(
                height: size.height / 6,
                margin: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.black,
                    blurRadius: 7
                  )]
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
                  child: InkWell(
                    onTap: () {
                      changeToTheme(lessonsNamesEn[index]);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, top: 25),
                          child: isTheme == false ? Text(lessonsNamesRu[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'DefaultFont')) :
                              Text(themesList[index])
                        )
                      ],
                    )
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                )
              ),
              itemCount: isTheme == false ? lessonsNamesRu.length : themesList.length
          ),
        ),
        if(isTheme == true)
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 10, left: 10),
            child: Container(
              width: size.width / 3,
              height: size.height / 14,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 204, 153, 1),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 7
                  )]
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    changeToTheme(null);
                  },
                  child: Center(
                    child: Text('Назад', style: TextStyle(fontFamily: 'DefaultFont', color: Colors.black, fontSize: 30)),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  void changeToTheme(nameLesson) {
    if(isTheme == false) {
      setState(() {
        isTheme = true;
      });

      firestoreInstance.collection('video_lesson').document('class_2').collection(nameLesson).orderBy("order").getDocuments().then((value) {
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
      });
    }
  }
}