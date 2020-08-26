import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'user_page.dart';
import 'package:thelearn/Widgets/size_config.dart';


class ProfilePage extends StatefulWidget{

  final String userUid;


  ProfilePage({Key key, @required this.userUid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(userUid);
}


class _ProfilePageState extends State<ProfilePage>{


  String nameValue, surnameValue, classValue;
  final String userUid;
  Image imageProfile;

  _ProfilePageState(this.userUid);

  Firestore firestoreInstance = Firestore.instance;

  List ratingNames = [];
  List videoNames = [];
  List userPhotos = [];
  List usersUid = [];
  int userRating;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        _refreshIndicatorKey.currentState.show());
  }

  File _imageFile;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    Size size = MediaQuery.of(context).size;
    print(devicePixelRatio);
    SizeConfig().init(context);
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await _refresh();
        },
        child: Scaffold(
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
                              child: InkWell(
                                child: imageProfile,
                                onTap: () async {
                                  await getImage();
                                  uploadPicture(context);
                                },
                              )
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
                        child: classValue != null ? Text('Класс: $classValue', style: TextStyle(fontWeight: FontWeight.bold)) : SpinKitWave(color: Colors.black12 , size: 15)
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
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(userUid: usersUid[index], userRating: index + 1)));
                              },
                              child: Container(
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text('${index + 1}', style: TextStyle(fontFamily: 'VideoFont', fontSize: 14)),
                                          SizedBox(width: size.width / 30),
                                          CircleAvatar(
                                            backgroundColor: Colors.redAccent,
                                            backgroundImage: NetworkImage(userPhotos[index]),
                                          ),
                                          SizedBox(width: size.width / 30),
                                          Text('${ratingNames[index]}', style: TextStyle(fontFamily: 'VideoFont', fontSize: 14)),
                                          SizedBox(width: size.width / 15),
                                          Text('${videoNames[index]} Видео', style: TextStyle(fontFamily: 'VideoFont', fontSize: 14))
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  )
                              ),
                            )
                        ),
                      ),
                    )
                  ],
                )
            )
        )
    );
  }


  void getRating() async {
    await firestoreInstance.collection('rating').orderBy('viewed_video', descending: true).limit(20).snapshots().listen((event) {
      ratingNames.clear();
      videoNames.clear();
      usersUid.clear();
      userPhotos.clear();
      event.documents.forEach((element) {
        firestoreInstance.collection('users').document(element.documentID).snapshots().listen((event) {
          setState(() {
            ratingNames.add(event.data['name'] + ' ' + event.data['surname']);
            userPhotos.add(event.data['photourl']);
            videoNames.add(element.data['viewed_video']);
            usersUid.add(element.documentID);
            if(event.documentID == userUid) {
              userRating = ratingNames.length;
            }
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
    await _cropImage();
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        cropStyle: CropStyle.rectangle,
        aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Обрезка фото',
            toolbarColor: Colors.redAccent,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
            hideBottomControls: true
        ),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    setState(() {
      _imageFile = croppedFile;
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
    }).then((value) async {
      await _refresh();
    });
  }

  void getUserInfo() {
    firestoreInstance.collection('users').document(userUid).get().then((value) {
      setState(() {
        nameValue = value.data['name'];
        surnameValue = value.data['surname'];
        classValue = value.data['class'];
        imageProfile = Image.network(value.data['photourl']);
      });
    });
  }


  Future<Null> _refresh() {
    getRating();
    getUserInfo();
    return null;
  }
}