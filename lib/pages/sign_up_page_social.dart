import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thelearn/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPageSocial extends StatefulWidget{

  final name, surname, email, photoUrl;

  SignUpPageSocial({Key key, @required this.name, this.surname, this.email, this.photoUrl}) : super(key: key);

  @override
  _SignUpStateSocial createState() => _SignUpStateSocial(name, surname, email, photoUrl);
}


class _SignUpStateSocial extends State<SignUpPageSocial>{

  final name, surname, email, photoUrl;
  _SignUpStateSocial(this.name, this.surname, this.email, this.photoUrl);

  final firestoreInstance = Firestore.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String _nameValue, _surnameValue;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    if(name != null) {
      _nameValue = name;
      _surnameValue = surname;
    }
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
              Form(
                key: _formKey1,
                child: Column(
                  children: <Widget>[
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
                              validator: (input) {
                                if(input.isEmpty){
                                  return 'Введите имя';
                                }
                              },
                              decoration: InputDecoration(
                                  hintText: 'Имя',
                                  hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 27)
                              ),
                              onSaved: (input) => _nameValue = input
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
                              validator: (input) {
                                if(input.isEmpty){
                                  return 'Введите фамилию';
                                }
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: 'Фамилия',
                                  hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 27)
                              ),
                              onSaved: (input) => _surnameValue = input
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
                        key: _formKey2,
                        hint: Text('Класс'),
                        value: dropdownValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(fontFamily: 'DefaultFont',color: Colors.deepPurpleAccent, fontSize: 27),
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
                        _createUserProfile();
                      },
                      child: Center(
                        child: Text('Войти', style: TextStyle(fontFamily: 'DefaultFont',color: Colors.white, fontSize: 45)),
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

  void _createUserProfile() async {
    if(_formKey1.currentState.validate()){
      _formKey1.currentState.save();
      var firebaseUser = await FirebaseAuth.instance.currentUser();
      firestoreInstance.collection("users").document(firebaseUser.uid).setData(
          {
            'name': _nameValue,
            'surname': _surnameValue,
            'class': dropdownValue,
            'email': email,
            'photourl': photoUrl
          }
      ).then((_) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(userUid: firebaseUser.uid)));
      });
    }
  }
}
