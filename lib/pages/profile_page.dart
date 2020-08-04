import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget{

  final String userUid;

  ProfilePage({Key key, @required this.userUid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Text('Профиль'),
    );
  }
}