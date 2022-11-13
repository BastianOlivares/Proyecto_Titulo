import 'package:flutter/material.dart';
import 'package:market_place/remote_data_sources/firestoreHelper.dart';

class editarPersonalPage extends StatefulWidget {
  final String uid;
  final String nombre;
  final String apellido;
  final int numeroTelefonico;

  const editarPersonalPage(
    this.uid, 
    this.nombre,
    this.apellido,
    this.numeroTelefonico,
    {super.key}
  );

  @override
  State<editarPersonalPage> createState() => _editarPersonalPageState();
}

class _editarPersonalPageState extends State<editarPersonalPage> {
    final TextEditingController _nombreController = TextEditingController();
    final TextEditingController _apellidoController = TextEditingController();
    final TextEditingController _numeroTelefonicoController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    _nombreController.text = widget.nombre;
    _apellidoController.text = widget.apellido;
    _numeroTelefonicoController.text = widget.numeroTelefonico.toString();


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
      home: Scaffold(
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
                              "Editar Datos Personales",
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
                                          controller: _apellidoController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "APELLIDO: ",
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
                                            if(value!.isEmpty) return 'El apellido no puede estar vacio';
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
                                          controller: _numeroTelefonicoController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            labelText: "NUMERO TELEFÓNICO: ",
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
                                          FirestoreHelper.editarDatosPersonales(
                                            widget.uid, 
                                            _nombreController.text, 
                                            _apellidoController.text, 
                                            int.parse(_numeroTelefonicoController.text)
                                          );
                                          Navigator.pop(context);
                                          showDialog(
                                            context: context, 
                                            builder: ((context) {
                                              return const AlertDialog(
                                                title: Text("¡Atencion!"),
                                                content: Text("Los datos han sido editados correctamente"),
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
      ),
    );
  }
}