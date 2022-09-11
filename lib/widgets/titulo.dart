import 'package:flutter/material.dart';

class titulo extends StatefulWidget {
  const titulo({super.key});

  @override
  State<titulo> createState() => _tituloState();
}

class _tituloState extends State<titulo> {
  @override
  Widget build(BuildContext context) {
    return Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 255, 7, 7),
    ),
    child: const Text("Market Place", style: TextStyle(
        color: Colors.white,
        fontSize: 25.0, 
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  }
}
