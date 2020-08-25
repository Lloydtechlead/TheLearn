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

  List data = [];
  List order = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getThemeData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 20),
        children: <Widget>[
          for(Widget widget in data)
            widget
        ],
      )
    );
  }


  void getThemeData() {
    firestoreInstance.collection('cribs').document('class_2').collection(cribName).document(cribThemeName).collection('data').orderBy('order').getDocuments().then((value) {
      value.documents.forEach((element) {
         if(element.data['type'] == 'image') {
           setState(() {
             data.add(imageContainer(element.data['image_url']));
           });
         }else {
           setState(() {
             data.add(
               Container(
                 margin: EdgeInsets.only(left: 10, right: 25),
                 child: Text(element.data['text'], style: TextStyle(fontSize: 20)),
               )
             );
           });
         }
      });
    });
  }

  Widget imageContainer(imageUrl) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          child: Image.asset('assets/crib_page_ventilator.gif', scale: 1.5),
        ),
        Container(
            height: 160,
            width: 230,
            margin: EdgeInsets.only(right: 10),
            color: Colors.black,
            child: Container(
                margin: EdgeInsets.all(3),
                color: Colors.grey[600],
                child: Stack(
                  children: <Widget>[
                    Image.asset('assets/crib_page_picture.png'),
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 7, bottom: 20, right: 0),
                      color: Colors.white,
                      child: Center(
                          child: GestureDetector(
                            child: Image.network(imageUrl),
                            onTap: () {
                              showFullPicture(context, imageUrl);
                            }
                          )
                      ),
                    ),
                  ],
                )
            )
        ),
        SizedBox(height: 20)
      ],
    );
  }

  void showFullPicture(BuildContext context, String imageUrl) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Hero(
              tag: 'Полноэкранная картинка',
              child: Image.network(imageUrl),
            ),
          ),
        )
      )
    );
}
}