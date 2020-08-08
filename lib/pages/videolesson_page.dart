import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoLessonPage extends StatefulWidget{

  final List lessonsNames;

  VideoLessonPage({Key key, @required this.lessonsNames}) : super(key: key);

  @override
  _VideoLessonPageState createState() => _VideoLessonPageState(lessonsNames);
}


class _VideoLessonPageState extends State<VideoLessonPage>{

  final List lessonsNames;
  _VideoLessonPageState(this.lessonsNames);

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            itemExtent: 170,
            diameterRatio: 3,
            squeeze: 0.8,
            renderChildrenOutsideViewport: true,
            clipToSize: false,
            physics: BouncingScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: lessonsNames.length,
              builder: (context, index) => Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Colors.black,
                    blurRadius: 10
                  )]
                ),
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  child: Center(
                      child: Text(lessonsNames[index])
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                  ),
                ),
              )
            ),
          )
        )
      ],
    );
  }
}
