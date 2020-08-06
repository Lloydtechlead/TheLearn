import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class ProfilePage extends StatefulWidget{

  final String userUid;


  ProfilePage({Key key, @required this.userUid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(userUid);
}


class _ProfilePageState extends State<ProfilePage>{

  String nameValue;
  String surnameValue;
  String classValue;
  String imageUrl;

  final String userUid;

  _ProfilePageState(this.userUid);

  Firestore firestoreInstance = Firestore.instance;


  @override
  void initState() {
    firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        nameValue = value.data['name'];
        surnameValue = value.data['surname'];
        classValue = value.data['class'];
        imageUrl = value.data['photourl'];
      });
    });
  }

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
                margin: imageUrl != null ? EdgeInsets.only(left: size.width / 8.5) : EdgeInsets.only(left: size.width / 8),
              child: imageUrl != null ? Image.network(imageUrl) : SpinKitCubeGrid(color: Colors.orangeAccent, size: 50)
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