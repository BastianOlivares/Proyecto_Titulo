import 'package:flutter/material.dart';

class appBarMod extends StatefulWidget {
  const appBarMod({super.key});

  @override
  State<appBarMod> createState() => _appBarModState();
}

class _appBarModState extends State<appBarMod> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        //automaticallyImplyLeading: false,
        title: const Text("Menu"),
        actions: <Widget> [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: ()=>{}
          ), 
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: ()=>{}
          ),
          IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: ()=>{}
          ),
        ],
      );
  }
}