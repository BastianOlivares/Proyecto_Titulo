import 'package:flutter/material.dart';
import 'package:market_place/pages/loginPage.dart';
import 'package:market_place/widgets/loginBody.dart';
import 'package:firebase_core/firebase_core.dart';


//void main() => runApp(const MyApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: loginPage(),
    );
  }
}


