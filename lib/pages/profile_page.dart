import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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

  final String userUid;

  _ProfilePageState(this.userUid);

  String imageUrl = 'https://firebasestorage.googleapis.com/v0/b/thelearn.appspot.com/o/profile_images%2Fprofile_avatar.jpg?alt=media&token=7e2637b5-39ed-448c-8949-19386f31fc2e';

  Firestore firestoreInstance = Firestore.instance;


  @override
  void initState() {
    firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        nameValue = value.data['name'];
        surnameValue = value.data['surname'];
        classValue =  value.data['class'];
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
              margin: EdgeInsets.only(left: size.width / 8.5),
              child: Image.network(imageUrl)
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: size.width / 8.5),
              child: Text(nameValue ?? 'Имя', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.only(left: size.width / 8.5),
                child: Text(surnameValue ?? 'Фамилия', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.only(left: size.width / 8.5),
                child: Text(classValue ?? 'Класс', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ),
          ],
        )
      )
    );
  }
}