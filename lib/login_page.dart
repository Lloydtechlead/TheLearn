import 'package:flutter/material.dart';
import 'Widgets/CustomIcons.dart';
import 'Widgets/SocialIcons.dart';
import 'main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'pages/sign_up_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{



  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  GoogleSignIn _googleSignIn = new GoogleSignIn();

  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            colors: [
              Colors.pink[900],
              Colors.pink[500],
              Colors.pink[300]
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('TheLearn - Учись, просто!', style: TextStyle(color: Colors.white, fontSize: 25))
                      ],
                    ),
                  ),
                  SizedBox(height: 15,)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Text('Вход в аккаунт', style: TextStyle(color: Colors.black, fontSize: 25),),
                      SizedBox(height: 50),
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(123, 104, 238, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (input) {
                                      if(input.isEmpty){
                                        return 'Введите вашу почту. Пример: thelearn@gmail.com';
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Введите вашу почту'
                                    ),
                                    onSaved: (input) => _email = input,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if(input.isEmpty){
                                        return 'Введите пароль';
                                      }
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: 'Введите пароль'
                                    ),
                                    onSaved: (input) => _password = input,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      InkWell(
                        child: Text('Забыли пароль?', style: TextStyle(color: Colors.grey, fontSize: 15)),
                        onTap: () {},
                      ),
                      SizedBox(height: 35),
                      InkWell(
                        child: Container(
                          width: 200,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.purple[200],
                              Colors.purple[400],
                              Colors.purple[700]
                            ]),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [BoxShadow(
                                color: Colors.pink.withOpacity(.3),
                                offset: Offset(0, 8),
                                blurRadius: 8
                            )],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                signInWithGoogle();
                                print(isSignIn);
                              },
                              child: Center(
                                child: Text('Войти', style: TextStyle(color: Colors.white, fontSize: 25)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 45),
                      Text('Вход через социальные сети', style: TextStyle(color: Colors.black, fontSize: 25)),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SocialIcon(
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
                          SocialIcon(
                            colors: [
                              Color(0xFFff4f38),
                              Color(0xFFff355d),
                            ],
                            iconData: CustomIcons.googlePlus,
                            onPressed: () {
                              handleSignIn();
                            },
                          ),
                          SocialIcon(
                            colors: [
                              Color(0xFF17ead9),
                              Color(0xFF6078ea),
                            ],
                            iconData: CustomIcons.twitter,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      SizedBox(height: 32),
                      InkWell(
                        child: Text('Регистрация', style: TextStyle(color: Colors.deepPurple,fontSize: 15)),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                        },
                      )
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }

  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;


    AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

    AuthResult result = (await _auth.signInWithCredential(credential));

    _user = result.user;
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));

    setState(() {
      isSignIn = true;
    });
  }

  Future<void> googleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = false;
      });
    });
  }

  Future<void> signInWithGoogle() async {
    final formState = _formKey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
      }catch(e){
        print(e.message);
      }
    }
  }

  void _signInFacebook() async {
    FacebookLogin facebookLogin = FacebookLogin();

    final result = await facebookLogin.logIn(['email']);
    final token = result.accessToken.token;
    final graphResponse = await http.get(
        'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${token}');
    if(result.status == FacebookLoginStatus.loggedIn){
      final credential = FacebookAuthProvider.getCredential(accessToken: token);
    }
  }
}