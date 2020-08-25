import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'Widgets/CustomIcons.dart';
import 'Widgets/SocialIcons.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/sign_up_page.dart';
import 'pages/sign_up_page_social.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoginPage extends StatefulWidget{

  final FirebaseUser user;
  final String nameValue, surnameValue, classValue;

  LoginPage({Key key, @required this.user, this.nameValue, this.surnameValue, this.classValue}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(user, nameValue, surnameValue, classValue);
}

class _LoginPageState extends State<LoginPage>{

  final FirebaseUser user;
  final String nameValue, surnameValue, classValue;

  _LoginPageState(this.user, this.nameValue, this.surnameValue, this.classValue);

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  String _email, _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final firestoreInstance = Firestore.instance;

  ProgressBar _sendingMsgProgressBar;

  @override
  void initState() {
    super.initState();
    _sendingMsgProgressBar = ProgressBar();
  }

  @override
  void dispose() {
    _sendingMsgProgressBar.hide();
    super.dispose();
  }

  @override
  void showSendingProgressBar() {
    _sendingMsgProgressBar.show(context);
  }

  @override
  void hideSendingProgressBar() {
    _sendingMsgProgressBar.hide();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Size size = MediaQuery.of(context).size;
    print(size.height);
    print(size.width);
    print(size.height / size.width);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_page_background.png'),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: size.height / 3 - 35),
            Container(
              margin: EdgeInsets.only(left: size.width / 3),
              child: Text('Вход', style: TextStyle(fontFamily: 'DefaultFont', fontSize: 70)),
            ),
            SizedBox(height: 25),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    height: size.height / 11,
                    margin: EdgeInsets.symmetric(horizontal: (size.width / (size.height / size.width)) / 2.5),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Введите электронный адрес',
                        hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 25)
                      ),
                      onSaved: (input) => _email = input,
                    ),
                  ),
                  SizedBox(height: size.height / 31),
                  Container(
                    padding: EdgeInsets.all(5),
                    height: size.height / 11,
                    margin: EdgeInsets.symmetric(horizontal: (size.width / (size.height / size.width)) / 2.5),
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Введите пароль',
                          hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 25)
                      ),
                      onSaved: (input) => _password = input,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 6.5),
            Container(
              margin: EdgeInsets.only(left: (size.width / (size.height / size.width)) / 4, right: (size.width / (size.height / size.width)) / 2.6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    alignment: Alignment.topLeft,
                    child: SocialIcon(
                      colors: [
                        Color(0xFF102397),
                        Color(0xFF187adf),
                        Color(0xFF00eaf8)
                      ],
                      iconData: CustomIcons.facebook,
                      onPressed: () {
                        _signInFacebook();
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: SocialIcon(
                      colors: [
                        Color(0xFF17ead9),
                        Color(0xFF6078ea),
                      ],
                      iconData: CustomIcons.twitter,
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: size.width / 2.3),
              child: SocialIcon(
                colors: [
                  Color(0xFFff4f38),
                  Color(0xFFff355d),
                ],
                iconData: CustomIcons.googlePlus,
                onPressed: () {
                  _handleSignIn();
                },
              ),
            ),
            Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    width: size.width / 2.5,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 204, 153, 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(-5, 0)
                      )]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                        child: Center(
                          child: Text('Регистрация', style: TextStyle(fontFamily: 'DefaultFont',color: Colors.black, fontSize: 40)),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width / 5),
                InkWell(
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: size.width / 3,
                    height: size.height / 14,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 204, 153, 1),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        offset: Offset(-5, 0)
                      )]
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          _signInWithGoogle();
                        },
                        child: Center(
                          child: Text('Вход', style: TextStyle(fontFamily: 'DefaultFont', color: Colors.black, fontSize: 40)),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Future<void> _handleSignIn() async {

    showSendingProgressBar();

    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;


    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;

    String userUid = _user.uid;

    writeSettings(String text) async {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/settings.txt');
      await file.writeAsString(text);
    }

    firestoreInstance.collection("users").document(userUid).get().then((value) {
      try {
        value.data['name'];
        writeSettings(userUid);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userUid: userUid)));
        setState(() {
          hideSendingProgressBar();
        });
      } catch (_) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPageSocial(name: _user.displayName, email: _user.email, userUid: userUid)));
        setState(() {
          hideSendingProgressBar();
        });
      }
    });
  }


  Future<void> _signInWithGoogle() async {

    showSendingProgressBar();

    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        if(user.user.isEmailVerified) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userUid: user.user.uid)));
          await _createUserProfile(nameValue, surnameValue, classValue);
          setState(() {
            hideSendingProgressBar();
          });
        }
      }catch(e){
        print(e.message);
        setState(() {
          hideSendingProgressBar();
        });
      }
    }
  }

  void _createUserProfile(_nameValue, _surnameValue, dropdownValue) async {
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      firestoreInstance.collection("users").document(firebaseUser.uid).setData(
          {
            'name': _nameValue,
            'surname': _surnameValue,
            'class': dropdownValue,
            'email': _email,
            'photourl': 'https://firebasestorage.googleapis.com/v0/b/thelearn.appspot.com/o/profile_images%2Fprofile_avatar.jpg?alt=media&token=15a87011-7190-4805-8555-f6565a42e759'
          }
      ).then((_) {
        print("success!");
      });
      firestoreInstance.collection('rating').document(firebaseUser.uid).setData({
        'viewed_video': 0,
        'test_results': 0
      }).then((value) {
        writeSettings(firebaseUser.uid);
      });
    }


  writeSettings(String text) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/settings.txt');
    await file.writeAsString(text);
    print('Успешно!');
  }


  void _signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    if(result.status == FacebookLoginStatus.loggedIn){
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
      _auth.signInWithCredential(credential);
    }
  }

  void navigateToSignUp(email, name, surname) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPageSocial(name: name, surname: surname)));
  }

}


class ProgressBar {

  OverlayEntry _progressOverlayEntry;

  void show(BuildContext context){
    _progressOverlayEntry = _createdProgressEntry(context);
    Overlay.of(context).insert(_progressOverlayEntry);
  }

  void hide(){
    if(_progressOverlayEntry != null){
      _progressOverlayEntry.remove();
      _progressOverlayEntry = null;
    }
  }

  OverlayEntry _createdProgressEntry(BuildContext context) =>
      OverlayEntry(
          builder: (BuildContext context) =>
              Center(
                child: SpinKitCircle(
                  color: Colors.blueAccent,
                  size: 70,
                )
              )
      );
}