import 'package:flutter/material.dart';
import 'package:market_place/functions/validarLogin.dart';

class botonEntrarFull extends StatefulWidget {
  const botonEntrarFull({super.key});

  @override
  State<botonEntrarFull> createState() => _botonEntrarFullState();
}

class _botonEntrarFullState extends State<botonEntrarFull> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      padding:  EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      child:  Text("Entrar"),
      onPressed: () => {
        if(validarLogin()) {

        // Navigator.push(context,MaterialPageRoute(builder:(context)=>menu()))
          Navigator.pushNamed(context, '/menu')
        }
        else {
          print("NOOOOOO")
        }
        
      }
    );
  }
}