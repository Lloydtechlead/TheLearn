import 'package:flutter/material.dart';


class SignUpPage2 extends StatefulWidget{

  @override
  _SignUpPageState2 createState() => _SignUpPageState2();
}


class _SignUpPageState2 extends State<SignUpPage2>{


  static const menuItems = <String>[
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];

  final List<DropdownMenuItem<String>> _dropDownMenuItems = menuItems.map(
      (String value) => DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      )
  ).toList();

  final List<PopupMenuItem> _popUpMenuItems = menuItems.map(
      (String value) => PopupMenuItem<String>(
        value: value,
        child: Text(value),
      )
  ).toList();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            colors: [
              Colors.blue[200],
              Colors.pink[200],
              Colors.pink[300],
              Colors.pink[600]
            ]
          )
        ),
        child: Column(
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
                  SizedBox(height: 150)
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 170,
                          height: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(37, 0, 255, .3),
                              blurRadius: 15,
                              offset: Offset(2, 5)
                            )]
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: Icon(Icons.account_circle),
                              hintText: 'Имя'
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: 200,
                          height: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [BoxShadow(
                                  color: Color.fromRGBO(37, 0, 255, .3),
                                  blurRadius: 15,
                                  offset: Offset(2, 5)
                              )]
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                                suffixIcon: Icon(Icons.account_circle),
                                hintText: 'Фамилия'
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 180,
                          height: 70,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(
                                color: Color.fromRGBO(37, 0, 255, .3),
                                blurRadius: 15,
                                offset: Offset(2, 5)
                            )]
                          ),
                          child: InkWell(
                            onTap: () async {
                              showDatePicker(context: context, initialDate: DateTime.now().add(Duration(seconds: 1)), firstDate: DateTime(1990), lastDate: DateTime.now());
                            },
                          ),
                        )
                      ],
                    )
                  ],
                )
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<DateTime>  _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime(1990),
    lastDate: DateTime.now()
  );
}