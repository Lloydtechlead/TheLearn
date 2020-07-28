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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email,_password;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.centerRight,
            image: AssetImage('assets/registration_picture.png'),
            fit: BoxFit.contain
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(color: Colors.transparent),
            SizedBox(height: 100),
            Container(
              margin: EdgeInsets.only(left: 15),
              height: 70,
              width: 140,
              padding: EdgeInsets.all(10),
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
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: 'Имя'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              margin: EdgeInsets.only(left: 55),
              height: 70,
              width: 160,
              padding: EdgeInsets.all(10),
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Фамилия'
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    height: 70,
                    width: 250,
                    padding: EdgeInsets.all(10),
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
                        TextFormField(
                          validator: (input) {
                            if(input.isEmpty){
                              return 'Введите электронный адрес';
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Электронная почта',
                          ),
                          onSaved: (input) => _email = input,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    margin: EdgeInsets.only(left: 35),
                    height: 70,
                    width: 140,
                    padding: EdgeInsets.all(10),
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
                        TextFormField(
                          validator: (input) {
                            if(input.length < 8){
                              return 'Пароль должен быть более 8 символов';
                            }
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Пароль'
                          ),
                            onSaved: (input) => _password = input
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: 100,
              height: 60,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(
                      color: Color.fromRGBO(123, 104, 238, .3),
                      blurRadius: 20,
                      offset: Offset(0, 10)
                  )]
              ),
              child: Center(
                child: DropdownButton<String>(
                    hint: Text('Класс'),
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                ),
              )
            ),
            SizedBox(height: 30),
            InkWell(
              child: Container(
                margin: EdgeInsets.only(left: 100),
                width: 260,
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
                      signUp();
                    },
                    child: Center(
                      child: Text('Зарегистрироваться', style: TextStyle(color: Colors.white, fontSize: 25)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  void signUp() async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
      }catch(e){
        print(e.message);
      }
    }
  }
}
