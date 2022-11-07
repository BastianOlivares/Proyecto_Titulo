import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/pages/loginPage.dart';
import 'package:market_place/pages/menu.dart';
import 'package:market_place/pages/registerPage.dart';
import 'package:firebase_core/firebase_core.dart';


//void main() => runApp(const MyApp());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp( MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 93, 162, 1),
        canvasColor: const Color.fromARGB(255, 173, 10, 81),
        cardColor: const Color.fromRGBO(218, 236, 139, 1),
        backgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
        focusColor: const Color.fromRGBO(71, 208, 189, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
      ),
      routes: <String, WidgetBuilder>{
        '/menu': (BuildContext context) => const menu(),
        '/register': (BuildContext context) => const registerPage(), //register()
      },
      debugShowCheckedModeBanner: false,
      home: StreamBuilder (
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.connectionState ==  ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasError) {
            return const Center(child: Text("ALGO SALIO MAL"));
          }
          else if(snapshot.hasData) {
            return  const menu();
          }
          else {
            return  const loginPage();
          }
        }
      ),
    );
  }
}



