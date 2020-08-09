import 'package:flutter/material.dart';
import 'package:thelearn/login_page.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String userData;
  try {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/settings.txt');
    userData = await file.readAsString();
    runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: MainPage(userUid: userData),
        )
    );
  } catch (e) {
    runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(  ),
        )
    );
  }
}