import 'package:flutter/material.dart';

class registrarButton extends StatefulWidget {
  const registrarButton({super.key});

  @override
  State<registrarButton> createState() => _registrarButtonState();
}

class _registrarButtonState extends State<registrarButton> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.redAccent,
      padding:  EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      child:  Text("Registrarse"),
      onPressed: () => {Navigator.pushNamed(context, '/register')}
    );
  }
}