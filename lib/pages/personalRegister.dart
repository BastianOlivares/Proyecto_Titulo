import 'package:flutter/material.dart';
import 'package:market_place/model/usuariosModel.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

class personalRegisterPage extends StatefulWidget {
  final String uid;//para ser llamado usar widget.[]
  const personalRegisterPage(
    this.uid,
    {super.key}
    );

  @override
  State<personalRegisterPage> createState() => _personalRegisterPageState();
}

class _personalRegisterPageState extends State<personalRegisterPage> {

  TextEditingController _nombreController = TextEditingController();
  TextEditingController _apellidoController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();


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
            children: [

              const Flexible(
                flex: 3,
                child: Center(
                  child: 
                    Text(
                      "Datos Personales",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white ,
                        fontSize: 80, 
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ),

              Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
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
                        child: ListView(
                          children: [

                            //NOMBRE
                            const Text(
                              "Nombre",
                              style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _nombreController,
                              style: const TextStyle(
                                color:  Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border:  UnderlineInputBorder(),
                                hintText: "Nombre",
                              ),
                            ),

                            const SizedBox(height: 50.0,),

                            //APELLIDO
                            const Text(
                              "Apellido",
                              style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              controller: _apellidoController,
                              style: const TextStyle(
                                color:  Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border:  UnderlineInputBorder(),
                                hintText: "Apellido",
                              ),
                            ),

                            const SizedBox(height: 50.0,),


                            //NUMERO TELEFONICO
                            const Text(
                              "Número Telefónico",
                              style: TextStyle(color: Colors.white ,fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [

                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Icon(
                                    Icons.phone_callback_rounded,
                                    color: Colors.white,
                                  ),
                                ),

                                const Padding(
                                  padding:  EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "+569",
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _telefonoController,
                                    style: const TextStyle(
                                      color:  Colors.white,
                                    ),
                                    decoration: const InputDecoration(
                                      border:  UnderlineInputBorder(),
                                      hintText: "12345678",
                                    ),
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: ((value) => 
                                      value != null && value.length < 8
                                      ? 'Ingresar número de teléfono valido '
                                      : null
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 50.0,),

                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll<Color> (Theme.of(context).focusColor)
                              ),
                              onPressed: (){ 

                                FirestoreHelper.crearUsuario(context, widget.uid, UsuarioModel(
                                  nombre: _nombreController.text, 
                                  apellido: _apellidoController.text, 
                                  numeroTelefonico: _telefonoController.text
                                ));
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Restrarse", 
                                style: TextStyle(fontSize: 20), 
                                
                              )
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ),


              const Expanded(flex: 1, child: SizedBox(height: 10,)),

            ],
          ),
        ),
      ),
    );
  }
}