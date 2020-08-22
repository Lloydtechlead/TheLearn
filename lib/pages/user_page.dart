import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thelearn/Widgets/size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserPage extends StatefulWidget {

  final String userUid;
  final int userRating;

  UserPage({Key key, @required this.userUid, this.userRating}) : super(key: key);

  @override
  UserPageState createState() => UserPageState(userUid, userRating);
}


class UserPageState extends State<UserPage> {

  final String userUid;
  final int userRating;

  UserPageState(this.userUid, this.userRating);

  Firestore firestoreInstance = Firestore.instance;

  String userName, userSurname, userClass, userPhoto;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    Size size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(1, SizeConfig.blockSizeVertical / -10),
            image: ExactAssetImage("assets/profile_page_notepad.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: SizeConfig.blockSizeVertical * 10),
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 13),
                  height: 122,
                  width: 92,
                  color: Colors.black,
                  child: Container(
                      color: Colors.white,
                      margin: EdgeInsets.all(2),
                      child: Image.network(userPhoto)
                  ),
                ),
                SizedBox(width: devicePixelRatio * 50),
                Container(
                  width: size.width / 6,
                  child: Text('Рейтинг по России $userRating', style: TextStyle(fontFamily: 'VideoFont', fontSize: 20)),
                )
              ],
            ),
            SizedBox(height: 20),
            Container(
                margin: userName != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
                child: userName != null ? Text(userName, style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
            SizedBox(height: 10),
            Container(
                margin: userSurname != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
                child: userSurname != null ? Text(userSurname, style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
            SizedBox(height: 10),
            Container(
                margin: userClass != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
                child: userClass != null ? Text('Класс: $userClass', style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
          ],
        ),
      ),
    );
  }


  void getUserInfo() async {

    await firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        userName = value.data['name'];
        userSurname = value.data['surname'];
        userClass = value.data['class'];
        userPhoto = value.data['photourl'];
      });
    });
  }
}