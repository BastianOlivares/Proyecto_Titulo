import 'package:flutter/material.dart';
import 'package:market_place/pages/loginPage.dart';
import 'package:market_place/pages/menu.dart';

Widget ruter() {
  return MaterialApp(
    // Inicie la aplicación con la ruta con nombre "/". En nuestro caso, la aplicación comenzará
    // en el Widget FirstScreen
    initialRoute: '/',
    routes: {
      // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
      '/': (context) => const loginPage(),
      // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
      '/second': (context) => const  menu(),
    },
  );
}