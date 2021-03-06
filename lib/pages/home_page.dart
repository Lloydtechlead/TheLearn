import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thelearn/services/admob_service.dart';
import 'package:admob_flutter/admob_flutter.dart';


class HomePage extends StatefulWidget{

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage>{

  final ams = AdMobService();

  Firestore firestoreInstance = Firestore.instance;
  List themesList = [];
  List themesUrl = ['https://www.youtube.com/watch?v=KJpkjHGiI5A&t=23s', 'https://www.youtube.com/watch?v=KJpkjHGiI5A&t=23s', 'https://www.youtube.com/watch?v=KJpkjHGiI5A&t=23s'];

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getNewVideos();
    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topLeft,
            image: ExactAssetImage("assets/home_page_progressbar.png", scale: 2.3)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(height: size.height / 1.85),
            Container(
              height: size.height / 12,
              width: size.width / 1.7,
              margin: EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .2),
                      blurRadius: 10,
                  )]
              ),
              child: Center(
                child: Text('Новые видео', style: TextStyle(fontFamily: 'DefaultFont', fontSize: 40)),
              ),
            ),
            Container(
              height: size.height / 4.5,
              margin: EdgeInsets.only(left: 20, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    color: Color.fromRGBO(123, 104, 238, .2),
                    blurRadius: 10,
                    offset: Offset(0, 10)
                  )]
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  height: 90,
                  width: 270,
                  margin: EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 10),
                  color: Colors.black,
                  child: Container(
                    margin: EdgeInsets.only(top: 2, bottom: 2, left: 3, right: 3),
                    child: createYoutubePlayerControllers(index),
                  )
                ),
                itemCount: themesUrl.length,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 0),
              child: AdmobBanner(
                adUnitId: ams.getBannerAdIdHomePage(),
                adSize: AdmobBannerSize.FULL_BANNER,
              ),
            )
          ],
        ),
      ),
    );
  }
  
  void getNewVideos() {
    
    firestoreInstance.collection('video_lesson').document('class_2').collection('mathematics').limit(5).getDocuments().then((value) {
      value.documents.forEach((element) {
        themesList.add(element.documentID);
        themesUrl.add(element.data['videourl']);
      });
    });
  }

  Widget createYoutubePlayerControllers(index) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(themesUrl[index]),
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true
      )
    );

    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        _controller.addListener(() {
          if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
            setState(() {
              _playerState = _controller.value.playerState;
              _videoMetaData = _controller.metadata;
            });
          }
        });
      },
    );
  }
}