import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thelearn/login_page.dart';


class SignUpPage extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUpPage>{

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
            SizedBox(height: 100),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text('Регистрация', style: TextStyle(color: Colors.white, fontSize: 30))
                      ],
                    ),
                  ),
                  SizedBox(height: 200)
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
                                          return 'Введите вашу почту';
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
                        SizedBox(height: 50),
                        InkWell(
                          child: Container(
                            width: 250,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.purple[200],
                                    Colors.purple[400],
                                    Colors.purple[700]
                                  ]
                              ),
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
                                  SignUp();
                                },
                                child: Center(
                                  child: Text(
                                    'Зарегистрироваться',
                                    style: TextStyle(color: Colors.white, fontSize: 25),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }


  void SignUp() async {
    if (_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
  }
}