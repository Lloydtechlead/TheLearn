import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thelearn/login_page.dart';


class SignUpPage extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: Colors.white,
        image: new DecorationImage(
          alignment: Alignment.topRight,
          image: new AssetImage('assets/registration_picture.png'),
          fit: BoxFit.contain
        )
      ),
    );
  }
}
