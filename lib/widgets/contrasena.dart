import 'package:flutter/material.dart';


class contrasena extends StatefulWidget {
  const contrasena({super.key});

  @override
  State<contrasena> createState() => _contrasenaState();
}

class _contrasenaState extends State<contrasena> {
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      obscureText: true, //oculta el texto
      decoration: InputDecoration(
        hintText: "contrasena",
        fillColor: Colors.redAccent,
        filled: true,
      ),
    ),
  );
  }
}
