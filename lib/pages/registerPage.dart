import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/loginBody.dart';
import 'package:market_place/widgets/registerBody.dart';
import 'package:market_place/pages/loginPage.dart';
import 'package:market_place/ruter.dart';

Widget registerPage() {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      routes: <String, WidgetBuilder>{
        '/loginPage': (BuildContext context) => loginBody(),
      },
      home: Scaffold(
        appBar: AppBar(
          title: Text("registro"),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 74, 74),
          ),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "asdasdasdas",
                ),
              ),

              TextFormField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: "asdasdasdas",
                ),
              )
            ],
          ),
        ),
      ));
}


/*class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}*/

/*class _registerState extends State<register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
    );
  }
}*/