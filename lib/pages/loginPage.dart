import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/pages/menu.dart';
import 'package:market_place/pages/register.dart';
import 'package:market_place/pages/registerPage.dart';
import 'package:market_place/ruter.dart';
import 'package:market_place/widgets/loginBody.dart';

Widget loginPage() {
  return MaterialApp(
      title: 'Material App',
      routes: <String, WidgetBuilder>{
        '/menu': (BuildContext context) => menu(),
        '/register': (BuildContext context) => registerPage(), //register()
      },
      home: Scaffold(
        body: loginBody(),
      ),
    );
}