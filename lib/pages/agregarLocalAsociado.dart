import 'package:address_search_field/address_search_field.dart';
import 'package:flutter/material.dart';
import 'package:market_place/widgets/googleMap.dart';

class agregarLocalAsociado extends StatefulWidget {
  const agregarLocalAsociado({super.key});

  @override
  State<agregarLocalAsociado> createState() => _agregarLocalAsociadoState();
}

class _agregarLocalAsociadoState extends State<agregarLocalAsociado> {
  
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _contactoController = TextEditingController();
  TextEditingController _correoController = TextEditingController();

  late var latitud;
  late var longitud;

  late TextEditingController controller;
  late Address destinationAddress;


  @override
  Widget build(BuildContext context) {
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
                    child: Column(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Text(
                            "Agregar local Asociado",
                            style: TextStyle(color: Colors.white ,fontSize: 50, fontWeight: FontWeight.bold),

                          ),
                        ),

                        Expanded(
                          flex: 9,
                          child: ListView(
                            children: [
                              input(_nombreController, "NOMBRE:", TextInputType.text, 1),
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
                                        GoogleMapHelper.panelGoogleMap(context, _direccionController);
                                      }
                                    ),
                                  ),
                                ),
                              ),
                              input(_contactoController, "CONTACTO: +569", TextInputType.text, 1),
                              input(_correoController, "CORREO:", TextInputType.text, 1),
                            ],
                          ),
                        )
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



              ],
            ),
          ),
        ),
      ),
    );
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