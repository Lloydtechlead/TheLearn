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
    print(lessonsNames);
    print(lessonsNames.length);
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Expanded(
          child: ListWheelScrollView.useDelegate(
            itemExtent: 200,
            diameterRatio: 3,
            renderChildrenOutsideViewport: true,
            clipToSize: false,
            physics: BouncingScrollPhysics(),
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: lessonsNames.length,
              builder: (context, index) => Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                color: Colors.grey[400],
                child: Center(
                  child: Text(lessonsNames[index])
                ),
              )
            ),
          )
        )
      ],
    );
  }
}
