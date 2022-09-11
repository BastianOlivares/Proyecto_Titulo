import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/stateFullButton.dart';

class registerBody extends StatefulWidget {
  const registerBody({super.key});

  @override
  State<registerBody> createState() => _registerBodyState();
}

class _registerBodyState extends State<registerBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 243, 74, 74),
      ),
      child: ListView(
        children: [TextFormField()],
      ),
    );
  }
}
