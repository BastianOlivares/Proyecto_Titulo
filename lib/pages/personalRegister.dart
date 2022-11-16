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

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
                        child: Form(
                          key: _formKey,
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
                                  errorStyle: TextStyle(color: Colors.white)
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: ((value){ 
                                  if(value!.isEmpty) return 'El nombre no puede estar vacio';
                                  return null;
                                }),
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
                                  errorStyle: TextStyle(color: Colors.white)
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: ((value){ 
                                  if(value!.isEmpty) return 'El apellido no puede estar vacio';
                                  return null;
                                }),
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
                                        errorStyle: TextStyle(color: Colors.white)
                                      ),
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      validator: ((value) {
                                        if(value!.isEmpty) return 'Ingrese un número valido';
                                          if(value.length < 8) return 'Ingrese al menos 8 digitos';
                                          if(value.length > 8) return 'Ingrese al lo mas 8 digitos';
                                          return null;
                                      }
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
                                  if(_formKey.currentState!.validate()) {
                                    FirestoreHelper.crearUsuario(context, widget.uid, UsuarioModel(
                                      nombre: _nombreController.text, 
                                      apellido: _apellidoController.text, 
                                      numeroTelefonico: int.parse(_telefonoController.text),
                                      tipoUsuario: 'cliente',
                                      localAsociado: ''
                                    ));
                                    Navigator.pop(context);
                                    setState(() {});
                                  }
                                },
                                child: const Text(
                                  "Registrarse", 
                                  style: TextStyle(fontSize: 20), 
                                  
                                )
                              ),
                        
                            ],
                          ),
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