import 'package:address_search_field/address_search_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

class editarDatosEmpresa extends StatefulWidget {
  final datosEmpresa;
  final String idLocal;
  const editarDatosEmpresa(this.datosEmpresa,this.idLocal,{super.key});

  @override
  State<editarDatosEmpresa> createState() => _editarDatosEmpresaState();
}

class _editarDatosEmpresaState extends State<editarDatosEmpresa> {

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contactoController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  static final geoMethods = GeoMethods(
    googleApiKey: 'AIzaSyBrVQpgmU6lo_zsSPoy5xxiSe90e2xy7Kw',
    language: 'es',
    countryCode: 'CL',
    country: 'Chile',
  );

  @override
  void initState() {
    _nombreController.text = widget.datosEmpresa['nombre'];
    _direccionController.text = widget.datosEmpresa['direccion'];
    _correoController.text = widget.datosEmpresa['correo'];
    _contactoController.text = widget.datosEmpresa['contacto'].toString();
    super.initState();
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _direccionController.dispose();
    _correoController.dispose();
    _contactoController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(255, 93, 162, 1),
        canvasColor: const Color.fromARGB(255, 173, 10, 81),
        cardColor: const Color.fromRGBO(218, 236, 139, 1),
        backgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
        focusColor: const Color.fromRGBO(71, 208, 189, 1),
        scaffoldBackgroundColor: const Color.fromRGBO(255, 253 , 214, 1),
      ),
      title: "Editar Publicacion",
      home:Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("EDITAR REGISTRO PERSONAL"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_outlined),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children : [

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
                    child: Column(
                      children: [

                        const Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Editar Datos Local Asociado",
                              style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),

                            ),
                          ),
                        ),


                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: ListView(
                                children: [

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
                                            if(value!.isEmpty) return 'El nombre no puede estar vacio';
                                            return null;
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),

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
                                          controller: _direccionController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "Dirección: ",
                                            labelStyle:  TextStyle(
                                              color: Colors.white
                                            ),
                                            errorStyle: TextStyle(color: Colors.white)
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
                                              ), 
                                            );
                                          },
                                          autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: ((value){ 
                                            if(value!.isEmpty) return 'La dirección no puede estar vacia';
                                            return null;
                                          }),
                                        ),
                                      ),
                                    ),
                                  ),

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
                                            labelText: "CONTACTO: ",
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


                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: FloatingActionButton.extended(
                                      elevation: 50.0,
                                      backgroundColor: const Color.fromRGBO(71, 208, 189, 1),
                                      onPressed: () {
                                        if(_formKey.currentState!.validate()) {
                                          FirestoreHelper.editarLocalAsociado(
                                            widget.idLocal, 
                                            _nombreController.text, 
                                            _direccionController.text, 
                                            _correoController.text, 
                                            int.parse(_contactoController.text)
                                          );
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
                                        'Editar',
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
                      ],
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


              ]
            ),
          ),
        ),
      )
    );
  }
}