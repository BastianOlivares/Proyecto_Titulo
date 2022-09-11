
import 'package:flutter/material.dart';

class campoUser extends StatefulWidget {
  const campoUser({super.key});

  @override
  State<campoUser> createState() => _campoUserState();
}

class _campoUserState extends State<campoUser> {
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: TextField(
      decoration: InputDecoration(
        hintText: "usuario",
        fillColor: Colors.redAccent,
        filled: true,
      ),
    ),
  );
  }
}
