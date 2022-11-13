import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class recuperarContraseniaPage extends StatefulWidget {
  const recuperarContraseniaPage({super.key});

  @override
  State<recuperarContraseniaPage> createState() => _recuperarContraseniaPageState();
}

class _recuperarContraseniaPageState extends State<recuperarContraseniaPage> {

  final TextEditingController _correoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: [
                            
                            const Center(
                              child: Text(
                                "RECUPERAR CONTRASEÑA",
                                style: TextStyle(color: Color.fromRGBO(71, 208, 189, 1) ,fontSize: 30, fontWeight: FontWeight.bold)
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                      
                            const Center(
                              child: Text(
                                "Aquí podras escribir tu correo y recibiras una solicitud en tu bandeja de entrada de la direccion dada, para recuperar tu contraseña.",
                                style: TextStyle(color: Colors.white,fontSize: 15, fontWeight: FontWeight.bold)
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
                                errorStyle: TextStyle(color: Colors.white)
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: ((value){ 
                                if(value!.isEmpty ) return 'Ingrese un correo valido';
                                if(!EmailValidator.validate(value)) return 'Ingrese un correo valido';
                                return null;
                              }),
                              
                            ),
                      
                            const Expanded(flex: 1, child: SizedBox(height: 30,)),
                      
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                              ),
                              onPressed: (() async {
                                if(_formKey.currentState!.validate()) {
                                  await FirebaseAuth.instance.sendPasswordResetEmail(email: _correoController.text.trim());
                                }
                                Navigator.pop(context);
                                showDialog(
                                  context: context, 
                                  builder: ((context) {
                                    return const AlertDialog(
                                      title: Text("Solicitu de Contraseña enviada!"),
                                      content: Text("Por favor revisar el correo ingresado y cambiar contraseña (buscar en spam)"),
                                    );
                                  })
                                );  
                               }),
                              child: const Text(
                                "ENVIAR SOLICITUD", 
                                style: TextStyle(fontSize: 20), 
                                
                              )
                            ),
                          ]
                        ),
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
}