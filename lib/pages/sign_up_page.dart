import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:thelearn/login_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class SignUpPage extends StatefulWidget{

  @override
  _SignUpState createState() => _SignUpState();
}


class _SignUpState extends State<SignUpPage>{

  final firestoreInstance = Firestore.instance;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  String _email,_password;
  String _nameValue, _surnameValue;
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            SizedBox(height: size.height / 8),
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
                 SizedBox(height: size.height / 18),
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
            SizedBox(height: size.height / 18),
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
                            hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 27)
                          ),
                          onSaved: (input) => _email = input,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height / 18),
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
                              hintText: 'Пароль',
                              hintStyle: TextStyle(fontFamily: 'DefaultFont', fontSize: 27)
                          ),
                            onSaved: (input) => _password = input
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height / 18),
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
            SizedBox(height: size.height / 19),
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
                      child: Text('Зарегистрироваться', style: TextStyle(fontFamily: 'DefaultFont',color: Colors.white, fontSize: 45)),
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
        _createUserProfile();
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }catch(e){
        print(e.message);
      }
    }
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
          'email': _email,
          'photourl': 'https://firebasestorage.googleapis.com/v0/b/thelearn.appspot.com/o/profile_images%2Fprofile_avatar.jpg?alt=media&token=15a87011-7190-4805-8555-f6565a42e759'
        }
      ).then((_) {
        print("success!");
      });
      firestoreInstance.collection('rating').document(firebaseUser.uid).setData({
        'viewed_video': 0,
        'test_results': 0
      });
    }
  }


}
