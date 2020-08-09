import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                      changeToTheme();
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 25, top: 25),
                          child: Text(lessonsNamesRu[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'DefaultFont')),
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
              itemCount: isTheme == false ? lessonsNamesRu.length : null
          ),
        )
      ],
    );
  }

  void changeToTheme() {
    if(isTheme == false) {
      isTheme = true;

    }else if(isTheme == true) {
      isTheme = false;
    }
  }
}