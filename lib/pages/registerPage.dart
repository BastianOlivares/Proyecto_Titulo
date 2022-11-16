import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class registerPage extends StatefulWidget {
  const registerPage({super.key});

  @override
  State<registerPage> createState() => _registerPageState();
}

class _registerPageState extends State<registerPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contraseniaController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Material App',
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
                      "ExFood ",
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
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            const Center(
                              child: Text(
                                "REGISTRO DE SESIÓN",
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
                              //keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                color:  Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border:  UnderlineInputBorder(),
                                hintText: "CORREO",
                                errorStyle: TextStyle(color: Colors.white)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (email) =>
                                email != null && EmailValidator.validate(email)
                                  ? null
                                  : 'Ingresar un correo valido',
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
                                hintText: "CONTRASEÑA",
                                errorStyle: TextStyle(color: Colors.white)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: ((value) => 
                                value != null && value.length < 6
                                ? 'Ingresar contraseña de minimo 6 caracteres'
                                : null
                              ),
                            ),
                             
                            const SizedBox(height: 50.0,),
                      
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                              ),
                              onPressed: sigUp,
                              child: const Text(
                                "Registrarse", 
                                style: TextStyle(fontSize: 20), 
                                
                              )
                            ),
                      
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "¿ Ya tienes cuenta ExFood ? ", 
                                  style: TextStyle(color: Colors.white),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Theme.of(context).focusColor,
                                  ), 
                                  child: const Text("¡ENTRA AQUÍ!")
                                )
                              ],
                            ) 
                      
                          ],
                        ),
                      ),
                    ),
                  )
                )
              ),

              const Expanded(flex: 1, child: SizedBox(height: 10,)),
          ],
        ),
      ),
    )
  );
  }

  Future sigUp() async {
    final valido = formKey.currentState!.validate();
    if(!valido) return;


    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: ((context) => const Center(child: CircularProgressIndicator()))
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _correoController.text.trim(),
        password: _contraseniaController.text,
      );
      Navigator.pop(context); //saca el showdialog
      Navigator.pop(context); //sale del loginpage y salta al menu
      
    }
    on FirebaseAuthException catch (e) {
      
      //LA UNICA EXCEPCION QUE FALTA POR CUBRRIR ES QUE EL CORREO YA EXISTA
      print(e);
      Navigator.pop(context);
      showDialog(
        context: context, 
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                height: 100.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(255, 93, 162, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child:  Center(
                    child: Text(
                      "Correo ya existe",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0
                      ),
                    )
                  ),
                ),
              ),
            ),
          );
        },
      );
      
    }

  }
}
