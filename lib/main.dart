import 'package:flutter/material.dart';
import 'package:thelearn/login_page.dart';

void main() {
  runApp(TheLearnApp());
}

class TheLearnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheLearn',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: LoginPage(),
    );
  }
}
