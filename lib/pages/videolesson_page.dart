import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thelearn/items/4th_class.dart';

class VideoLessonPage extends StatefulWidget{

  @override
  _VideoLessonPageState createState() => _VideoLessonPageState();
}


class _VideoLessonPageState extends State<VideoLessonPage>{

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  List<Widget> itemsData = [];


  void getPostsData() {
    Colors _containerColor;
    List<dynamic> responseList = FORTYTH_CLASS;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.pink.withAlpha(100), blurRadius: 5)
        ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Text(post["name"], style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          ),
        ),
      ));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            controller: controller,
            itemCount: itemsData.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return itemsData[index];
            },
          ),
        )
      ],
    );
  }
}