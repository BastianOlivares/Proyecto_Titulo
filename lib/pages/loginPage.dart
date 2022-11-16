
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/pages/recuperarContraseniaPage.dart';
import 'package:market_place/pages/registerPage.dart';


class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();
  
  @override
  void dispose() {
    _contraseniaController.dispose();
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExFood',
      home: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 93, 162, 1)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Flexible(
                flex: 3,
                child: Center(
                  child: 
                    Text(
                      "ExFood",
                      style: TextStyle(color: Colors.white ,fontSize: 80, fontWeight: FontWeight.bold),
                    )
                ),
              ),

              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 207, 74, 132),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(108, 41, 41, 41),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(10, 10),
                        )
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          
                          const Center(
                            child: Text(
                              "INCIO DE SESIÓN",
                              style: TextStyle(color: Color.fromRGBO(71, 208, 189, 1) ,fontSize: 30, fontWeight: FontWeight.bold)
                            ),
                          ),

                          const SizedBox(height: 50.0,),
                          
                          const Text(
                            "Correo",
                            style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _correoController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(
                              color:  Colors.white,
                            ),
                            decoration: const InputDecoration(
                              border:  UnderlineInputBorder(),
                              hintText: "CORREO",
                            ),
                            
                          ),

                          const SizedBox(height: 20.0,),

                          const Text(
                            "Contraseña",
                            style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            controller: _contraseniaController,
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            style: const TextStyle(
                              color:  Colors.white,
                              decorationColor: Colors.white
                            ),
                            decoration: const InputDecoration(
                              border:  UnderlineInputBorder(),
                              hintText: "CONTRASEÑA"
                            ),
                          ),

                          const SizedBox(height: 50.0,),

                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                            ),
                            onPressed: sigIn,
                            child: const Text(
                              "Iniciar Sesión", 
                              style: TextStyle(fontSize: 20), 
                              
                            )
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "¿No tienes cuenta ExFood?", 
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(builder: (context) => const registerPage())
                                  );
                                  
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(context).focusColor,
                                ), 
                                child: const Text("¡REGISTRATE AQUÍ!")
                              )
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "¿Olvidates tu contraseña? ", 
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const recuperarContraseniaPage(),));
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Theme.of(context).focusColor,
                                ), 
                                child: const Text("INGRESA AQUÍ")
                              )
                            ],
                          ) 
                        ]
                      ),
                    ),
                  ),
                ),
              ),

              const Expanded(flex: 1, child: SizedBox(height: 10,)),
            ],
          ),
        )
      ),
    );
  }


  Future sigIn() async {
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ((context) => const Center(child: CircularProgressIndicator()))
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _correoController.text.trim(),
        password: _contraseniaController.text,
      );
      Navigator.pop(context);
    }
    on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ((context) {
        return AlertDialog(
        title: const Text("¡Algo salio Mal!"),
        content: const  Text("Datos ingresados son incorrectos"),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
            }, 
            child:const Text("Volver")
          )
        ],
      );
      })
    );
      print(e);
    }

  }
}

