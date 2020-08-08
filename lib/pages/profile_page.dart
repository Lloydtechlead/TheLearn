import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProfilePage extends StatefulWidget{

  final String nameValue, surnameValue, classValue;
  Image imageProfile;


  ProfilePage({Key key, @required this.nameValue, this.surnameValue, this.classValue, this.imageProfile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(nameValue, surnameValue, classValue, imageProfile);
}


class _ProfilePageState extends State<ProfilePage>{

  final String nameValue, surnameValue, classValue;
  Image imageProfile;

  _ProfilePageState(this.nameValue, this.surnameValue, this.classValue, this.imageProfile);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(1, -0.7),
            image: ExactAssetImage("assets/profile_page_notepad.png"),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height * 0.13),
            Container(
              height: 100,
              width: 100,
                margin: EdgeInsets.only(left: size.width / 8),
              child: imageProfile
            ),
            SizedBox(height: 20),
            Container(
              margin: nameValue != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
              child: nameValue != null ? Text(nameValue, style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
            SizedBox(height: 10),
            Container(
                margin: surnameValue != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
                child: surnameValue != null ? Text(surnameValue, style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
            SizedBox(height: 10),
            Container(
                margin: classValue != null ? EdgeInsets.only(left: size.width / 8) : EdgeInsets.only(right: size.width / 1.5),
                child: classValue != null ? Text(classValue, style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
            ),
          ],
        )
      )
    );
  }
}