import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:thelearn/utilities/keys.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ThemePage extends StatefulWidget {

  final String lessonName, themeName, classValue, userUid;

  ThemePage({Key key, @required this.lessonName, this.themeName, this.classValue, this.userUid}) : super(key: key);

  @override
  ThemePageState createState() => ThemePageState(lessonName, themeName, classValue, userUid);
}


class ThemePageState extends State<ThemePage> {

  final String lessonName, themeName, classValue, userUid;

  ThemePageState(this.lessonName, this.themeName,  this.classValue, this.userUid);

  Firestore firestoreInstance = Firestore.instance;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;
  String videoUrl;
  bool isPlay = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVideoUrl();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              height: size.height,
              width: size.width / 7,
              color: Colors.black,
              child:  Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Colors.brown
                ),
              )
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              children: <Widget>[SizedBox(height: 30),
                Container(
                  height: 180,
                  width: 320,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    boxShadow: [BoxShadow(
                      color: Colors.black,
                      blurRadius: 5
                    )]
                  ),
                  child: Container(
                      margin: EdgeInsets.all(3),
                      child: isPlay == true ? videoPlayer() : Text('Загрузка...', style: TextStyle(color: Colors.white),)
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: size.width / 1.5,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(themeName, style: TextStyle(fontFamily: 'VideoFont', fontSize: 15),),
                ),
                SizedBox(height: 45),
                RotationTransition(
                  turns: AlwaysStoppedAnimation(15 / 360),
                  child: Container(
                    height: 200,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [BoxShadow(
                        color: Colors.black,
                        blurRadius: 5
                      )]
                    ),
                    child: Container(
                      margin: EdgeInsets.all(2),
                      padding: EdgeInsets.all(10),
                      color: Colors.amberAccent,
                      child: Text('Не хотите ли вы пройти тест по этой теме ?', style: TextStyle(fontFamily: 'VideoFont', fontSize: 20)),
                    ),
                  ),
                ),
                SizedBox(height: 150),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 0, right: 0),
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Material(
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                              boxShadow: [BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 5
                              )]
                          ),
                          child: Center(
                            child: Text('Назад', style: TextStyle(fontFamily: 'VideoFont', fontSize: 30),),
                          ),
                        ),
                      ),
                      ),
                    )
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void getVideoUrl() {
    firestoreInstance.collection('video_lesson').document('class_$classValue').collection(lessonName).document(themeName).get().then((value) {
      setState(() {
        videoUrl = YoutubePlayer.convertUrlToId(value.data['videourl']);
        isPlay = true;
      });
    });
  }

  Widget videoPlayer() {
    return YoutubePlayer(
      controller: YoutubePlayerController(
          initialVideoId: videoUrl,
          flags: YoutubePlayerFlags(
              autoPlay: false,
              mute: true,
          ),
      ),
      showVideoProgressIndicator: true,
      onReady: () {},
      onEnded: (data) => addValue()
    );
  }


  Future<void> addValue() {

    firestoreInstance.collection('rating').document(userUid).get().then((value) {
      firestoreInstance.collection('rating').document(userUid).collection('viewed_video').where('theme_name', isEqualTo: themeName).getDocuments().then((data) {
          if(data.documents.length == 0) {
            firestoreInstance.collection('rating').document(userUid).updateData({
              'viewed_video': value.data['viewed_video'] + 1
            });
            firestoreInstance.collection('rating').document(userUid).collection('viewed_video').document(themeName).setData({
              'theme_name': themeName
            });
          }
      });
    });
  }
}