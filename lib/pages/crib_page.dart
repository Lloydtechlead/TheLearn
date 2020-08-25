import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class CribPage extends StatefulWidget {

  final String cribName, cribThemeName;

  CribPage({Key key, @required this.cribName, this.cribThemeName}) : super(key: key);

  @override
  CribPageState createState() => CribPageState(cribName, cribThemeName);
}


class CribPageState extends State<CribPage> {

  final String cribName, cribThemeName;

  CribPageState(this.cribName, this.cribThemeName);

  Firestore firestoreInstance = Firestore.instance;

  Set data = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    data.forEach((element) {
      print(element);
    });
    // TODO: implement build
    return Scaffold();
  }


  void getThemeData() {
    firestoreInstance.collection('cribs').document('class_2').collection(cribName).document(cribThemeName).collection('data').orderBy('order').getDocuments().then((value) {
      value.documents.forEach((element) {
         setState(() {
           data.add(element.data);
         });
      });
    });
  }
}