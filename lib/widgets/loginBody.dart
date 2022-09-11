import 'package:flutter/material.dart';
import 'package:market_place/widgets/campoUser.dart';
import 'package:market_place/widgets/contrasena.dart';
import 'package:market_place/widgets/registrarButton.dart';
import 'package:market_place/widgets/stateFullButton.dart';
import 'package:market_place/widgets/titulo.dart';


class loginBody extends StatefulWidget {
  const loginBody({super.key});

  @override
  State<loginBody> createState() => _loginBodyState();
}

class _loginBodyState extends State<loginBody> {
  @override

  Widget build(BuildContext context) {
    return Container(
    decoration:  const BoxDecoration(
      image: DecorationImage(
        image: NetworkImage("https://www.leanandgreenbusiness.com/wp-content/uploads/2019/04/images1889-5ca5983e24411-1024x683.jpg"),
        fit: BoxFit.cover,
        )
    ),
    child: Center(
      child: Column (
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titulo(),
          const SizedBox(height: 20.0),
          campoUser(),
          const SizedBox(height: 20.0),
          contrasena(),
          const SizedBox(height: 20.0),
          botonEntrarFull(),
          const SizedBox(height: 20.0),
          registrarButton()
        ],
      ),
    ),
  );
  }
}
