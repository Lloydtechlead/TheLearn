import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';


class ProfilePage extends StatefulWidget{

  final String nameValue, surnameValue, classValue, userUid;
  Image imageProfile;


  ProfilePage({Key key, @required this.nameValue, this.surnameValue, this.classValue, this.imageProfile, this.userUid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(nameValue, surnameValue, classValue, imageProfile, userUid);
}


class _ProfilePageState extends State<ProfilePage>{

  final String nameValue, surnameValue, classValue, userUid;
  Image imageProfile;

  _ProfilePageState(this.nameValue, this.surnameValue, this.classValue, this.imageProfile, this.userUid);

  Firestore firestoreInstance = Firestore.instance;

  List ratingNames = [];
  List videoNames = [];

  @override
  void initState() {
    getRating();
  }

  File _imageFile;

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
              margin: EdgeInsets.only(left: size.width / 8),
              height: 100,
              width: 80,
              color: Colors.black,
              child: Container(
                  color: Colors.white,
                  margin: EdgeInsets.all(3),
                  child: InkWell(
                    child: imageProfile,
                    onTap: () async {
                      await getImage();
                      uploadPicture(context);
                    },
                  )
              ),
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
            SizedBox(height: size.height / 6),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text('Рейтинг по России', style: TextStyle(fontFamily: 'VideoFont', fontSize: 30))
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              height: size.height / 3.5,
              width: size.width / 1.05,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Container(
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ListView.builder(
                  itemCount: ratingNames.length,
                  itemBuilder: (_, index) => Container(
                    padding: EdgeInsets.only(bottom: 20, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('${index + 1} ${ratingNames[index]}', style: TextStyle(fontFamily: 'VideoFont', fontSize: 20)),
                        Text('${videoNames[index]} Видео', style: TextStyle(fontFamily: 'VideoFont', fontSize: 20))
                      ],
                    )
                  ),
                )
              ),
            )
          ],
        )
      )
    );
  }
  
  
  void getRating() {
    firestoreInstance.collection('rating').orderBy("viewed_video", descending: true).getDocuments().then((result) {
      result.documents.forEach((element) {
        firestoreInstance.collection('users').document(element.documentID).get().then((value) {
          setState(() {
            ratingNames.add(value['name'] + ' ' + value['surname']);
            videoNames.add(element.data['viewed_video']);
          });
        });
      });
    });
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = image;
    });
  }

  Future uploadPicture(BuildContext context) async {
    String fileName = basename(_imageFile.path);
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('profile_images');
    StorageUploadTask uploadTask = firebaseStorageRef.child(userUid).putFile(_imageFile);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then((value) {
      firestoreInstance.collection('users').document(userUid).updateData({
        'photourl': value
      });
    });
  }
}