import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CribsPage extends StatefulWidget {

  @override
  CribsPageState createState() => CribsPageState();
}

class CribsPageState extends State<CribsPage> {

  Firestore firestoreInstance = Firestore.instance;

  List cribsList = [];
  
  @override
  void initState() {
    super.initState();
    getCribs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              reverse: true,
              itemCount: cribsList.length,
              itemBuilder: (context, index) => InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: [BoxShadow(
                            color: Colors.black,
                            blurRadius: 7
                        )]
                    ),
                    child: Container(
                      height: 100,
                      margin: EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(left: 14, right: 14, top: 2, bottom: 2),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Column(
                          crossAxisAlignment:  CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(cribsList[index])
                          ],
                        ),
                      ),
                    ),
                  )
              )
          ),
        ),
        Image.asset('assets/videolesson_picture_1.png'),
      ],
    );
  }
  
  void getCribs() {
    firestoreInstance.collection('cribs').snapshots().listen((event) {
      event.documents.forEach((element) {
        setState(() {
          cribsList.add(element.documentID);
        });
      });
    });
  }
  
  Widget imageContainer(image) {
    
    return Container(
        margin: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width - 200) / 2),
        height: 190,
        width: 210,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/crib_page_ventilator.gif', scale: 1.5),
              alignment: Alignment.topRight,
            ),
            SizedBox(width: 3),
            Container(
                height: 140,
                width: 210,
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
                            child: Text('В будующих обновлениях!', style: TextStyle(fontFamily: 'VideoFont', fontSize: 15),),
                          ),
                        ),
                      ],
                    )
                )
            )
          ],
        )
    );
  }
}