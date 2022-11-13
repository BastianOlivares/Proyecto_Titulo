import 'package:address_search_field/address_search_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:market_place/model/localAsociadoModel.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

class agregarLocalAsociado extends StatefulWidget {
  const agregarLocalAsociado({super.key});

  @override
  State<agregarLocalAsociado> createState() => _agregarLocalAsociadoState();
}

class _agregarLocalAsociadoState extends State<agregarLocalAsociado> {
  //RESCATAR DATOS DEL USUARIO Q ENTRO
  User auth = FirebaseAuth.instance.currentUser!;
  late String uid;

  final _formKey = GlobalKey<FormState>();
  
  static final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyBrVQpgmU6lo_zsSPoy5xxiSe90e2xy7Kw',
    language: 'es',
    countryCode: 'CL',
    country: 'Chile',
  );

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();

  late var latitud;
  late var longitud;

  late TextEditingController controller;
  late Address destinationAddress;


  @override
  Widget build(BuildContext context) {
    inputUidUser(); 
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agregar local asociado",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("AGREGAR LOCAL ASOCIADO"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Container (
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [

                Expanded(
                  flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const  BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topLeft: Radius.circular(20.0),
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          const Padding(
                            padding:  EdgeInsets.all(10.0),
                            child:  Expanded(
                              flex: 1,
                              child: Text(
                                "Agregar local Asociado",
                                style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),

                          //NOMBRE DEL LOCAL
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _nombreController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "NOMBRE: ",
                                    labelStyle:  TextStyle(
                                      color: Colors.white
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: const TextStyle(
                                    color:  Colors.white,
                                  ), 
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: ((value){ 
                                    if(value!.isEmpty) return 'Ingrese un nombre de Local';
                                    return null;
                                  }),
                                ),
                              ),
                            ),
                          ),


                          //DIRECCION DEL LOCAL
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  controller: _direccionController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "DIRECCION : ",
                                    labelStyle: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                                  style: const TextStyle(
                                    color:  Colors.white,
                                  ),
                                  onTap: () async { 
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) => AddressSearchDialog(
                                        geoMethods: geoMethods,
                                        controller: _direccionController,
                                        onDone: (Address address) {
                                          latitud = address.coords!.latitude;
                                          longitud = address.coords!.longitude;
                                        }
                                      ), 
                                    );
                                  },
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: ((value){ 
                                    if(value!.isEmpty) return 'Ingrese una Dirección';
                                    return null;
                                  }),
                                ),
                              ),
                            ),
                          ),

                          //CONTACTO DEL LOCAL
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _contactoController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "CONTAACTO: +569",
                                    labelStyle:  TextStyle(
                                      color: Colors.white
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: const TextStyle(
                                    color:  Colors.white,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: ((value){ 
                                    if(value!.isEmpty) return 'Ingrese un número valido';
                                    if(value.length < 8) return 'Ingrese al menos 8 digitos';
                                    if(value.length > 8) return 'Ingrese al lo mas 8 digitos';
                                    return null;
                                  }),
                                ),
                              ),
                            ),
                          ),
                          
                          //CORREO DEL LOCAL
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _correoController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: "CORREO: ",
                                    labelStyle:  TextStyle(
                                      color: Colors.white
                                    ),
                                    errorStyle: TextStyle(color: Colors.white)
                                  ),
                                  style: const TextStyle(
                                    color:  Colors.white,
                                  ),
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: ((value){ 
                                    if(value!.isEmpty ) return 'Ingrese un correo valido';
                                    if(!EmailValidator.validate(value)) return 'Ingrese un correo valido';
                                    return null;
                                  }),
                                ),
                              ),
                            ),
                          ),
                    
                          //BOTON REGISTRAR LOCAL
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FloatingActionButton.extended(
                              elevation: 50.0,
                              backgroundColor: const Color.fromRGBO(71, 208, 189, 1),
                              onPressed: () {
                                //AQUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
                                if(_formKey.currentState!.validate()) {
                                  FirestoreHelper.crearLocalAsociado(uid, LocalAsociadoModel(
                                    nombre: _nombreController.text,
                                    direccion: _direccionController.text, 
                                    contacto: int.parse(_contactoController.text), 
                                    correo: _correoController.text
                                  ));
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context, 
                                    builder: ((context) {
                                      return const AlertDialog(
                                        title: Text("¡Atención!"),
                                        content: Text("Los datos del Local han sido guardados exitosamente"),
                                      );
                                    })
                                  );
                                }
                              }, 
                              label: const Text(
                                'Registrar',
                                style: TextStyle(color: Colors.white ,fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              icon: const Icon(Icons.check),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                Expanded(
                  flex: 1,
                  child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                  ),
                ),



              ],
            ),
          ),
        ),
      ),
    );
  }

  void inputUidUser() {
    uid = (auth.uid).toString();
  }


  Widget input(TextEditingController controlador, String label, TextInputType inputType, int maxLineas) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextFormField(
            maxLines: maxLineas,
            keyboardType: inputType,
            controller: controlador,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: label,
              labelStyle: const TextStyle(
                color: Colors.white
              )
            ),
            style: const TextStyle(
              color:  Colors.white,
            )
          ),
        ),
      ),
    );
  }
}